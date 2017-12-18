From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/5] perf jvmti: Generate correct debug information for inlined code
Date: Mon, 18 Dec 2017 11:39:10 -0300
Message-ID: <20171218143912.6036-4-acme@kernel.org>
References: <20171218143912.6036-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758376AbdLROjf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Dec 2017 09:39:35 -0500
In-Reply-To: <20171218143912.6036-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Colin King <colin.king@canonical.com>, Darren Hart <dvhart@infradead.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Kim Phillips <kim.phillips@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Ben Gainey <ben.gainey@arm.com>

tools/perf/jvmti is broken in so far as it generates incorrect debug
information. Specifically it attributes all debug lines to the original
method being output even in the case that some code is being inlined
from elsewhere.  This patch fixes the issue.

To test (from within linux/tools/perf):

export JDIR=/usr/lib/jvm/java-8-openjdk-amd64/
make
cat << __EOF > Test.java
public class Test
{
    private StringBuilder b = new StringBuilder();

    private void loop(int i, String... args)
    {
        for (String a : args)
            b.append(a);

        long hc = b.hashCode() * System.nanoTime();

        b = new StringBuilder();
        b.append(hc);

        System.out.printf("Iteration %d = %d\n", i, hc);
    }

    public void run(String... args)
    {
        for (int i = 0; i < 10000; ++i)
        {
            loop(i, args);
        }
    }

    public static void main(String... args)
    {
        Test t = new Test();
        t.run(args);
    }
}
__EOF
$JDIR/bin/javac Test.java
./perf record -F 10000 -g -k mono $JDIR/bin/java -agentpath:`pwd`/libperf-jvmti.so Test
./perf inject --jit -i perf.data -o perf.data.jitted
./perf annotate -i perf.data.jitted --stdio | grep Test\.java: | sort -u

Before this patch, Test.java line numbers get reported that are greater
than the number of lines in the Test.java file.  They come from the
source file of the inlined function, e.g. java/lang/String.java:1085.
For further validation one can examine those lines in the JDK source
distribution and confirm that they map to inlined functions called by
Test.java.

After this patch, the filename of the inlined function is output
rather than the incorrect original source filename.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ben Gainey <ben.gainey@arm.com>
Cc: Colin King <colin.king@canonical.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 598b7c6919c7 ("perf jit: add source line info support")
Link: http://lkml.kernel.org/r/20171122182541.d25599a3eb1ada3480d142fa@arm.com
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/jvmti/jvmti_agent.c |  16 +++--
 tools/perf/jvmti/jvmti_agent.h |   7 +-
 tools/perf/jvmti/libjvmti.c    | 147 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 134 insertions(+), 36 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index cf36de7ea255..0c6d1002b524 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -384,13 +384,13 @@ jvmti_write_code(void *agent, char const *sym,
 }
 
 int
-jvmti_write_debug_info(void *agent, uint64_t code, const char *file,
-		       jvmti_line_info_t *li, int nr_lines)
+jvmti_write_debug_info(void *agent, uint64_t code,
+    int nr_lines, jvmti_line_info_t *li,
+    const char * const * file_names)
 {
 	struct jr_code_debug_info rec;
-	size_t sret, len, size, flen;
+	size_t sret, len, size, flen = 0;
 	uint64_t addr;
-	const char *fn = file;
 	FILE *fp = agent;
 	int i;
 
@@ -405,7 +405,9 @@ jvmti_write_debug_info(void *agent, uint64_t code, const char *file,
 		return -1;
 	}
 
-	flen = strlen(file) + 1;
+	for (i = 0; i < nr_lines; ++i) {
+	    flen += strlen(file_names[i]) + 1;
+	}
 
 	rec.p.id        = JIT_CODE_DEBUG_INFO;
 	size            = sizeof(rec);
@@ -421,7 +423,7 @@ jvmti_write_debug_info(void *agent, uint64_t code, const char *file,
 	 * file[]   : source file name
 	 */
 	size += nr_lines * sizeof(struct debug_entry);
-	size += flen * nr_lines;
+	size += flen;
 	rec.p.total_size = size;
 
 	/*
@@ -452,7 +454,7 @@ jvmti_write_debug_info(void *agent, uint64_t code, const char *file,
 		if (sret != 1)
 			goto error;
 
-		sret = fwrite_unlocked(fn, flen, 1, fp);
+		sret = fwrite_unlocked(file_names[i], strlen(file_names[i]) + 1, 1, fp);
 		if (sret != 1)
 			goto error;
 	}
diff --git a/tools/perf/jvmti/jvmti_agent.h b/tools/perf/jvmti/jvmti_agent.h
index fe32d8344a82..6ed82f6c06dd 100644
--- a/tools/perf/jvmti/jvmti_agent.h
+++ b/tools/perf/jvmti/jvmti_agent.h
@@ -14,6 +14,7 @@ typedef struct {
 	unsigned long	pc;
 	int		line_number;
 	int		discrim; /* discriminator -- 0 for now */
+	jmethodID	methodID;
 } jvmti_line_info_t;
 
 void *jvmti_open(void);
@@ -22,11 +23,9 @@ int   jvmti_write_code(void *agent, char const *symbol_name,
 		       uint64_t vma, void const *code,
 		       const unsigned int code_size);
 
-int   jvmti_write_debug_info(void *agent,
-		             uint64_t code,
-			     const char *file,
+int   jvmti_write_debug_info(void *agent, uint64_t code, int nr_lines,
 			     jvmti_line_info_t *li,
-			     int nr_lines);
+			     const char * const * file_names);
 
 #if defined(__cplusplus)
 }
diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index c62c9fc9a525..6add3e982614 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -47,6 +47,7 @@ do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
 			tab[lines].pc = (unsigned long)pc;
 			tab[lines].line_number = loc_tab[i].line_number;
 			tab[lines].discrim = 0; /* not yet used */
+			tab[lines].methodID = m;
 			lines++;
 		} else {
 			break;
@@ -125,6 +126,99 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
 	return JVMTI_ERROR_NONE;
 }
 
+static void
+copy_class_filename(const char * class_sign, const char * file_name, char * result, size_t max_length)
+{
+	/*
+	* Assume path name is class hierarchy, this is a common practice with Java programs
+	*/
+	if (*class_sign == 'L') {
+		int j, i = 0;
+		char *p = strrchr(class_sign, '/');
+		if (p) {
+			/* drop the 'L' prefix and copy up to the final '/' */
+			for (i = 0; i < (p - class_sign); i++)
+				result[i] = class_sign[i+1];
+		}
+		/*
+		* append file name, we use loops and not string ops to avoid modifying
+		* class_sign which is used later for the symbol name
+		*/
+		for (j = 0; i < (max_length - 1) && file_name && j < strlen(file_name); j++, i++)
+			result[i] = file_name[j];
+
+		result[i] = '\0';
+	} else {
+		/* fallback case */
+		size_t file_name_len = strlen(file_name);
+		strncpy(result, file_name, file_name_len < max_length ? file_name_len : max_length);
+	}
+}
+
+static jvmtiError
+get_source_filename(jvmtiEnv *jvmti, jmethodID methodID, char ** buffer)
+{
+	jvmtiError ret;
+	jclass decl_class;
+	char *file_name = NULL;
+	char *class_sign = NULL;
+	char fn[PATH_MAX];
+	size_t len;
+
+	ret = (*jvmti)->GetMethodDeclaringClass(jvmti, methodID, &decl_class);
+	if (ret != JVMTI_ERROR_NONE) {
+		print_error(jvmti, "GetMethodDeclaringClass", ret);
+		return ret;
+	}
+
+	ret = (*jvmti)->GetSourceFileName(jvmti, decl_class, &file_name);
+	if (ret != JVMTI_ERROR_NONE) {
+		print_error(jvmti, "GetSourceFileName", ret);
+		return ret;
+	}
+
+	ret = (*jvmti)->GetClassSignature(jvmti, decl_class, &class_sign, NULL);
+	if (ret != JVMTI_ERROR_NONE) {
+		print_error(jvmti, "GetClassSignature", ret);
+		goto free_file_name_error;
+	}
+
+	copy_class_filename(class_sign, file_name, fn, PATH_MAX);
+	len = strlen(fn);
+	*buffer = malloc((len + 1) * sizeof(char));
+	if (!*buffer) {
+		print_error(jvmti, "GetClassSignature", ret);
+		ret = JVMTI_ERROR_OUT_OF_MEMORY;
+		goto free_class_sign_error;
+	}
+	strcpy(*buffer, fn);
+	ret = JVMTI_ERROR_NONE;
+
+free_class_sign_error:
+	(*jvmti)->Deallocate(jvmti, (unsigned char *)class_sign);
+free_file_name_error:
+	(*jvmti)->Deallocate(jvmti, (unsigned char *)file_name);
+
+	return ret;
+}
+
+static jvmtiError
+fill_source_filenames(jvmtiEnv *jvmti, int nr_lines,
+		      const jvmti_line_info_t * line_tab,
+		      char ** file_names)
+{
+	int index;
+	jvmtiError ret;
+
+	for (index = 0; index < nr_lines; ++index) {
+		ret = get_source_filename(jvmti, line_tab[index].methodID, &(file_names[index]));
+		if (ret != JVMTI_ERROR_NONE)
+			return ret;
+	}
+
+	return JVMTI_ERROR_NONE;
+}
+
 static void JNICALL
 compiled_method_load_cb(jvmtiEnv *jvmti,
 			jmethodID method,
@@ -135,16 +229,18 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 			const void *compile_info)
 {
 	jvmti_line_info_t *line_tab = NULL;
+	char ** line_file_names = NULL;
 	jclass decl_class;
 	char *class_sign = NULL;
 	char *func_name = NULL;
 	char *func_sign = NULL;
-	char *file_name= NULL;
+	char *file_name = NULL;
 	char fn[PATH_MAX];
 	uint64_t addr = (uint64_t)(uintptr_t)code_addr;
 	jvmtiError ret;
 	int nr_lines = 0; /* in line_tab[] */
 	size_t len;
+	int output_debug_info = 0;
 
 	ret = (*jvmti)->GetMethodDeclaringClass(jvmti, method,
 						&decl_class);
@@ -158,6 +254,19 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 		if (ret != JVMTI_ERROR_NONE) {
 			warnx("jvmti: cannot get line table for method");
 			nr_lines = 0;
+		} else if (nr_lines > 0) {
+			line_file_names = malloc(sizeof(char*) * nr_lines);
+			if (!line_file_names) {
+				warnx("jvmti: cannot allocate space for line table method names");
+			} else {
+				memset(line_file_names, 0, sizeof(char*) * nr_lines);
+				ret = fill_source_filenames(jvmti, nr_lines, line_tab, line_file_names);
+				if (ret != JVMTI_ERROR_NONE) {
+					warnx("jvmti: fill_source_filenames failed");
+				} else {
+					output_debug_info = 1;
+				}
+			}
 		}
 	}
 
@@ -181,33 +290,14 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 		goto error;
 	}
 
-	/*
-	 * Assume path name is class hierarchy, this is a common practice with Java programs
-	 */
-	if (*class_sign == 'L') {
-		int j, i = 0;
-		char *p = strrchr(class_sign, '/');
-		if (p) {
-			/* drop the 'L' prefix and copy up to the final '/' */
-			for (i = 0; i < (p - class_sign); i++)
-				fn[i] = class_sign[i+1];
-		}
-		/*
-		 * append file name, we use loops and not string ops to avoid modifying
-		 * class_sign which is used later for the symbol name
-		 */
-		for (j = 0; i < (PATH_MAX - 1) && file_name && j < strlen(file_name); j++, i++)
-			fn[i] = file_name[j];
-		fn[i] = '\0';
-	} else {
-		/* fallback case */
-		strcpy(fn, file_name);
-	}
+	copy_class_filename(class_sign, file_name, fn, PATH_MAX);
+
 	/*
 	 * write source line info record if we have it
 	 */
-	if (jvmti_write_debug_info(jvmti_agent, addr, fn, line_tab, nr_lines))
-		warnx("jvmti: write_debug_info() failed");
+	if (output_debug_info)
+		if (jvmti_write_debug_info(jvmti_agent, addr, nr_lines, line_tab, (const char * const *) line_file_names))
+			warnx("jvmti: write_debug_info() failed");
 
 	len = strlen(func_name) + strlen(class_sign) + strlen(func_sign) + 2;
 	{
@@ -223,6 +313,13 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 	(*jvmti)->Deallocate(jvmti, (unsigned char *)class_sign);
 	(*jvmti)->Deallocate(jvmti, (unsigned char *)file_name);
 	free(line_tab);
+	while (line_file_names && (nr_lines > 0)) {
+	    if (line_file_names[nr_lines - 1]) {
+	        free(line_file_names[nr_lines - 1]);
+	    }
+	    nr_lines -= 1;
+	}
+	free(line_file_names);
 }
 
 static void JNICALL
-- 
2.13.6
