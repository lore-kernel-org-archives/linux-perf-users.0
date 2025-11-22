Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1012E22BF
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799599; cv=none; b=NPpzldt826YPxcwbBwPN71+zxiy5/uFOqFyrxvZ28FgPidUWtBLY1Bsz8Z+DFSs9Dsp7phUPywnIx4FDX/6ASxMumjpxa+HXyQ298Og5jztWvGb9BhX6Xl4Mkw69Bj5eyl7zBSAXvu0pa/O3FaZswnofV9p3exbPlazkb6u+nKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799599; c=relaxed/simple;
	bh=3qBlJKk1kVkHDxdezjAgYYdWUiOjKjzmMQFfmn1yqOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gfq7oAsqoUhwb62hHmg0wPeIYY9cG/G6+WJVeHWW19gJC5EZ3OrpfDQcb/gI+R3+sQCHU3s/vNKFAWnlo6mNqVgwzvIoyZG6jlY58AogwAxChDiL7A3SzW5IoT9VfBDXe3Hj7x44Ra2oQ5hzrQccU0HVBjmQwrEl0OgvhcMvfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBhg+LWH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBhg+LWH"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so5232225a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799597; x=1764404397; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTgSld+zWldBlIj9iQhUFIRYK7znK8Muttybqj8QK0I=;
        b=OBhg+LWHMe5qgXbtiPl84PR5Qm9nLEkw/mEW5zbaJh0cxNDKuZ2D1bIflQmoqweMm+
         5mRD4NiFE9gZgmuljfwGd6dODioAtS+POKWZV1f320dNnfFhAo913IjIfl41ZjjRJXvw
         s+aramDbabMdXw3HPiV8TNv1RifKdazaI+KozrRNv8To07AjS3Mf/hqn1c8zenpIF3x9
         uWq7Nh3YHmcqyfLN5SJrTKBf7GxmshOiQdXArDRBNb3mdGgx7hC67KaIgWb7MoFYNLsj
         1XTMHDLPwL4Igm51t5OCuqy5GAKvTg9+3ClTFA7uzR3YxjDPzPgM4/ObxMR/bTOASTQe
         vYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799597; x=1764404397;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTgSld+zWldBlIj9iQhUFIRYK7znK8Muttybqj8QK0I=;
        b=U230dhmgMGYVB6rBW+2PAWDC3gLL6RKO71JzDm6MOFDItl2bBdCB9TPFqqxJH5orc4
         9AmJ/UulP4tE7OtAV8BHdDKTBb3ka+TOpMxMUB1v/sSoyot0iysH2W5ui1zgkGKLWM9z
         5wcb/VSbsyNuL1A2A8VHvmoastE4cDSJpUEDcCTfp7a8lhU9Lx3YXCxehhRaVvyzPfBI
         tcvgUUBTH0LxuBPYsdDSiHTKLxUMAJDLOkUINkh6w9sriUb8l4372okCDDq6tVqxZT/M
         +deEzkFgGs7BoRjLhqXBJIakhx9LEkVuD1zB6xEdKMWu+Qaig8m5EgPeX6mXRUPP4vIh
         feRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYLpgFVl7T8Z5EYzCKNbpGaawVd9KrkK6KWllvqn/BOvQNmgm7tOuALs/4pzi7sMuOdnm392KLfiGq0B0sLzSy@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUt1rvGkZOnTfu1070HPFdJElry61GEP5jHUUM/sAe53GZyYh
	/IgOXA2g8Fs+7rDb95HZ24eBZyQUUne/KTRdsnc5GovRYjAO0eaTSWK++vNMW1lQuN4M3kTVroc
	8kpQrB5sc/g==
X-Google-Smtp-Source: AGHT+IEGZTx82yh6ivSmLyr5eVGFroWnq6Ir7ehD9mrmhm4DljU3Ki7EE9oibo+Jz1VZpx2AIRZHFRGUQN6s
X-Received: from dyaa12.prod.google.com ([2002:a05:693c:40cc:b0:2a2:4eb1:3771])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5502:b0:2a4:7f22:cc0d
 with SMTP id 5a478bee46e88-2a7192ce4b1mr2237806eec.32.1763799596840; Sat, 22
 Nov 2025 00:19:56 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:23 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-12-irogers@google.com>
Subject: [PATCH v1 11/17] perf tests buildid: Add purge and remove testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add testing for the purge and remove commands. Use the noploop
workload rather than just a return to avoid missing samples in the
workload in perf record. Tidy up the cleanup code to cleanup when
signals happen.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/buildid.sh | 203 ++++++++++++++++++++++++++----
 1 file changed, 177 insertions(+), 26 deletions(-)

diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
index d2eb213da01d..102808cca9db 100755
--- a/tools/perf/tests/shell/buildid.sh
+++ b/tools/perf/tests/shell/buildid.sh
@@ -36,16 +36,69 @@ if [ ${run_pe} -eq 1 ]; then
 	unset WAYLAND_DISPLAY
 fi
 
-ex_md5=$(mktemp /tmp/perf.ex.MD5.XXX)
-ex_sha1=$(mktemp /tmp/perf.ex.SHA1.XXX)
+build_id_dir=
+ex_source=$(mktemp /tmp/perf_buildid_test.ex.XXX.c)
+ex_md5=$(mktemp /tmp/perf_buildid_test.ex.MD5.XXX)
+ex_sha1=$(mktemp /tmp/perf_buildid_test.ex.SHA1.XXX)
 ex_pe=$(dirname $0)/../pe-file.exe
+data=$(mktemp /tmp/perf_buildid_test.data.XXX)
+log_out=$(mktemp /tmp/perf_buildid_test.log.out.XXX)
+log_err=$(mktemp /tmp/perf_buildid_test.log.err.XXX)
 
-echo 'int main(void) { return 0; }' | cc -Wl,--build-id=sha1 -o ${ex_sha1} -x c -
-echo 'int main(void) { return 0; }' | cc -Wl,--build-id=md5 -o ${ex_md5} -x c -
+cleanup() {
+	rm -f ${ex_source} ${ex_md5} ${ex_sha1} ${data} ${log_out} ${log_err}
+	if [ ${run_pe} -eq 1 ]; then
+		rm -r ${wineprefix}
+	fi
+        if [ -d ${build_id_dir} ]; then
+		rm -rf ${build_id_dir}
+        fi
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+# Test program based on the noploop workload.
+cat <<EOF > ${ex_source}
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
 
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig)
+{
+	(void)sig;
+	done = 1;
+}
+
+int main(int argc, const char **argv)
+{
+	int sec = 1;
+
+	if (argc > 1)
+		sec = atoi(argv[1]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done)
+		continue;
+
+	return 0;
+}
+EOF
+cc -Wl,--build-id=sha1 ${ex_source} -o ${ex_sha1} -x c -
+cc -Wl,--build-id=md5 ${ex_source} -o ${ex_md5} -x c -
 echo "test binaries: ${ex_sha1} ${ex_md5} ${ex_pe}"
 
-check()
+get_build_id()
 {
 	case $1 in
 	*.exe)
@@ -64,6 +117,15 @@ check()
 		id=`readelf -n ${1} 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
 		;;
 	esac
+	echo ${id}
+}
+
+check()
+{
+	file=$1
+	perf_data=$2
+
+	id=$(get_build_id $file)
 	echo "build id: ${id}"
 
 	id_file=${id#??}
@@ -76,45 +138,53 @@ check()
 		exit 1
 	fi
 
-	file=${build_id_dir}/.build-id/$id_dir/`readlink ${link}`/elf
-	echo "file: ${file}"
+	cached_file=${build_id_dir}/.build-id/$id_dir/`readlink ${link}`/elf
+	echo "file: ${cached_file}"
 
 	# Check for file permission of original file
 	# in case of pe-file.exe file
 	echo $1 | grep ".exe"
 	if [ $? -eq 0 ]; then
-		if [ -x $1 ] && [ ! -x $file ]; then
-			echo "failed: file ${file} executable does not exist"
+		if [ -x $1 ] && [ ! -x $cached_file ]; then
+			echo "failed: file ${cached_file} executable does not exist"
 			exit 1
 		fi
 
-		if [ ! -x $file ] && [ ! -e $file ]; then
-			echo "failed: file ${file} does not exist"
+		if [ ! -x $cached_file ] && [ ! -e $cached_file ]; then
+			echo "failed: file ${cached_file} does not exist"
 			exit 1
 		fi
-	elif [ ! -x $file ]; then
-		echo "failed: file ${file} does not exist"
+	elif [ ! -x $cached_file ]; then
+		echo "failed: file ${cached_file} does not exist"
 		exit 1
 	fi
 
-	diff ${file} ${1}
+	diff ${cached_file} ${1}
 	if [ $? -ne 0 ]; then
-		echo "failed: ${file} do not match"
+		echo "failed: ${cached_file} do not match"
 		exit 1
 	fi
 
-	${perf} buildid-cache -l | grep ${id}
+	${perf} buildid-cache -l | grep -q ${id}
 	if [ $? -ne 0 ]; then
 		echo "failed: ${id} is not reported by \"perf buildid-cache -l\""
 		exit 1
 	fi
 
+	if [ -n "${perf_data}" ]; then
+		${perf} buildid-list -i ${perf_data} | grep -q ${id}
+		if [ $? -ne 0 ]; then
+			echo "failed: ${id} is not reported by \"perf buildid-list -i ${perf_data}\""
+			exit 1
+		fi
+	fi
+
 	echo "OK for ${1}"
 }
 
 test_add()
 {
-	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
+	build_id_dir=$(mktemp -d /tmp/perf_buildid_test.debug.XXX)
 	perf="perf --buildid-dir ${build_id_dir}"
 
 	${perf} buildid-cache -v -a ${1}
@@ -128,12 +198,88 @@ test_add()
 	rm -rf ${build_id_dir}
 }
 
+test_remove()
+{
+	build_id_dir=$(mktemp -d /tmp/perf_buildid_test.debug.XXX)
+	perf="perf --buildid-dir ${build_id_dir}"
+
+	${perf} buildid-cache -v -a ${1}
+	if [ $? -ne 0 ]; then
+		echo "failed: add ${1} to build id cache"
+		exit 1
+	fi
+
+	id=$(get_build_id ${1})
+	if ! ${perf} buildid-cache -l | grep -q ${id}; then
+		echo "failed: ${id} not in cache"
+		exit 1
+	fi
+
+	${perf} buildid-cache -v -r ${1}
+	if [ $? -ne 0 ]; then
+		echo "failed: remove ${id} from build id cache"
+		exit 1
+	fi
+
+	if ${perf} buildid-cache -l | grep -q ${id}; then
+		echo "failed: ${id} still in cache after remove"
+		exit 1
+	fi
+
+	echo "remove: OK"
+	rm -rf ${build_id_dir}
+}
+
+test_purge()
+{
+	build_id_dir=$(mktemp -d /tmp/perf_buildid_test.debug.XXX)
+	perf="perf --buildid-dir ${build_id_dir}"
+
+	id1=$(get_build_id ${ex_sha1})
+	${perf} buildid-cache -v -a ${ex_sha1}
+	if ! ${perf} buildid-cache -l | grep -q ${id1}; then
+		echo "failed: ${id1} not in cache"
+		exit 1
+	fi
+
+	id2=$(get_build_id ${ex_md5})
+	${perf} buildid-cache -v -a ${ex_md5}
+	if ! ${perf} buildid-cache -l | grep -q ${id2}; then
+		echo "failed: ${id2} not in cache"
+		exit 1
+	fi
+
+	# Purge by path
+	${perf} buildid-cache -v -p ${ex_sha1}
+	if [ $? -ne 0 ]; then
+		echo "failed: purge build id cache of ${ex_sha1}"
+		exit 1
+	fi
+
+	${perf} buildid-cache -v -p ${ex_md5}
+	if [ $? -ne 0 ]; then
+		echo "failed: purge build id cache of ${ex_md5}"
+		exit 1
+	fi
+
+	# Verify both are gone
+	if ${perf} buildid-cache -l | grep -q ${id1}; then
+		echo "failed: ${id1} still in cache after purge"
+		exit 1
+	fi
+
+	if ${perf} buildid-cache -l | grep -q ${id2}; then
+		echo "failed: ${id2} still in cache after purge"
+		exit 1
+	fi
+
+	echo "purge: OK"
+	rm -rf ${build_id_dir}
+}
+
 test_record()
 {
-	data=$(mktemp /tmp/perf.data.XXX)
-	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
-	log_out=$(mktemp /tmp/perf.log.out.XXX)
-	log_err=$(mktemp /tmp/perf.log.err.XXX)
+	build_id_dir=$(mktemp -d /tmp/perf_buildid_test.debug.XXX)
 	perf="perf --buildid-dir ${build_id_dir}"
 
 	echo "running: perf record $*"
@@ -145,7 +291,7 @@ test_record()
 	fi
 
 	args="$*"
-	check ${args##* }
+	check ${args##* } ${data}
 
 	rm -f ${log_out} ${log_err}
 	rm -rf ${build_id_dir}
@@ -166,10 +312,15 @@ if [ ${run_pe} -eq 1 ]; then
 	test_record wine ${ex_pe}
 fi
 
-# cleanup
-rm ${ex_sha1} ${ex_md5}
-if [ ${run_pe} -eq 1 ]; then
-	rm -r ${wineprefix}
+# remove binaries manually via perf buildid-cache -r
+test_remove ${ex_sha1}
+test_remove ${ex_md5}
+if [ ${add_pe} -eq 1 ]; then
+	test_remove ${ex_pe}
 fi
 
+# purge binaries manually via perf buildid-cache -p
+test_purge
+
+cleanup
 exit 0
-- 
2.52.0.rc2.455.g230fcf2819-goog

