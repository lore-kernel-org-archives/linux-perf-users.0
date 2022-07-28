Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D706C19F2B
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 14:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiG1ORR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1ORQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 10:17:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C00852479
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 07:17:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDBF1106F;
        Thu, 28 Jul 2022 07:17:14 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C4633F70D;
        Thu, 28 Jul 2022 07:17:13 -0700 (PDT)
Message-ID: <b6798d9f-2d81-2a39-1406-9b9770b016ae@foss.arm.com>
Date:   Thu, 28 Jul 2022 15:17:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/14] perf test: Refactor shell tests allowing subdirs
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
 <20220712135750.2212005-2-carsten.haitzler@foss.arm.com>
 <20220713065328.GB1354743@leoy-ThinkPad-X240s>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220713065328.GB1354743@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 7/13/22 07:53, Leo Yan wrote:
> On Tue, Jul 12, 2022 at 02:57:37PM +0100, carsten.haitzler@foss.arm.com wrote:
>> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
>>
>> This is a prelude to adding more tests to shell tests and in order to
>> support putting those tests into subdirectories, I need to change the
>> test code that scans/finds and runs them.
>>
>> To support subdirs I have to recurse so it's time to refactor the code to
>> allow this and centralize the shell script finding into one location and
>> only one single scan that builds a list of all the found tests in memory
>> instead of it being duplicated in 3 places.
>>
>> This code also optimizes things like knowing the max width of desciption
>> strings (as we can do that while we scan instead of a whole new pass
>> of opening files). It also more cleanly filters scripts to see only
>> *.sh files thus skipping random other files in directories like *~
>> backup files, other random junk/data files that may appear and the
>> scripts must be executable to make the cut (this ensures the script
>> lib dir is not seen as scripts to run). This avoids perf test running
>> previous older versions of test scripts that are editor backup files
>> as well as skipping perf.data files that may appear and so on.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   tools/perf/tests/Build               |   1 +
>>   tools/perf/tests/builtin-test-list.c | 201 +++++++++++++++++++++++++++
>>   tools/perf/tests/builtin-test-list.h |  12 ++
>>   tools/perf/tests/builtin-test.c      | 152 +++-----------------
>>   4 files changed, 232 insertions(+), 134 deletions(-)
>>   create mode 100644 tools/perf/tests/builtin-test-list.c
>>   create mode 100644 tools/perf/tests/builtin-test-list.h
>>
>> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
>> index af2b37ef7c70..2064a640facb 100644
>> --- a/tools/perf/tests/Build
>> +++ b/tools/perf/tests/Build
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>>   perf-y += builtin-test.o
>> +perf-y += builtin-test-list.o
>>   perf-y += parse-events.o
>>   perf-y += dso-data.o
>>   perf-y += attr.o
>> diff --git a/tools/perf/tests/builtin-test-list.c b/tools/perf/tests/builtin-test-list.c
>> new file mode 100644
>> index 000000000000..1e60088c1005
>> --- /dev/null
>> +++ b/tools/perf/tests/builtin-test-list.c
>> @@ -0,0 +1,201 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#include <fcntl.h>
>> +#include <errno.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <stdlib.h>
>> +#include <sys/types.h>
>> +#include <dirent.h>
>> +#include <sys/wait.h>
>> +#include <sys/stat.h>
>> +#include "builtin.h"
>> +#include "hist.h"
>> +#include "intlist.h"
>> +#include "tests.h"
>> +#include "debug.h"
>> +#include "color.h"
>> +#include <subcmd/parse-options.h>
>> +#include "string2.h"
>> +#include "symbol.h"
>> +#include "util/rlimit.h"
>> +#include <linux/kernel.h>
>> +#include <linux/string.h>
>> +#include <subcmd/exec-cmd.h>
>> +#include <linux/zalloc.h>
> 
> I know some files in perf do not strictly use the alphabet ordering
> for headers, but this is the convention for Linux mainline code.

These headers do indeed come from other perf source files.

> It would be better to use the below ordering (just an example which
> doesn't contain complete headers for this patch):

OK. It seems to not affect it (sometimes order does). These headers came 
from other existing code that didn't care about sorting at all so the 
design precedent was that order is irrelevant, but I can do this.

>> +
>> +#include "builtin-test-list.h"
>> +
>> +#include <linux/ctype.h>
> 
> #include <dirent.h>
> #include <errno.h>
> #include <fcntl.h>
> ...
> #include <linux/ctype.h>
> #include <linux/kernel.h>
> #include <linux/string.h>
> #include <linux/zalloc.h>
> #include <stdlib.h>
> ...
> #include <unistd.h>
> 
> #include "builtin.h"
> #include "debug.h"
> ...
> 
>> +
>> +/* As this is a singleton built once for the run of the process, there is
>> + * no value in trying to free it and just let it stay around until process
>> + * exits when it's cleaned up. */
> 
> Multple comments format is:
> 
> /*
>   * As this is a singleton built once for the run of the process, there is
>   * no value in trying to free it and just let it stay around until process
>   * exits when it's cleaned up.
>   */

OK - will do.

>> +static size_t files_num = 0;
>> +static struct script_file *files = NULL;
>> +static int files_max_width = 0;
>> +
>> +static const char *shell_tests__dir(char *path, size_t size)
>> +{
>> +	const char *devel_dirs[] = { "./tools/perf/tests", "./tests", };
>> +	char *exec_path;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
>> +		struct stat st;
>> +
>> +		if (!lstat(devel_dirs[i], &st)) {
>> +			scnprintf(path, size, "%s/shell", devel_dirs[i]);
>> +			if (!lstat(devel_dirs[i], &st))
>> +				return path;
>> +		}
>> +	}
>> +
>> +	/* Then installed path. */
>> +	exec_path = get_argv_exec_path();
>> +	scnprintf(path, size, "%s/tests/shell", exec_path);
>> +	free(exec_path);
>> +	return path;
>> +}
>> +
>> +static const char *shell_test__description(char *description, size_t size,
>> +                                           const char *path, const char *name)
>> +{
>> +	FILE *fp;
>> +	char filename[PATH_MAX];
>> +	int ch;
>> +
>> +	path__join(filename, sizeof(filename), path, name);
>> +	fp = fopen(filename, "r");
>> +	if (!fp)
>> +		return NULL;
>> +
>> +	/* Skip first line - should be #!/bin/sh Shebang */
>> +	do {
>> +		ch = fgetc(fp);
>> +	} while (ch != EOF && ch != '\n');
>> +
>> +	description = fgets(description, size, fp);
>> +	fclose(fp);
>> +
>> +	/* Assume first char on line is omment everything after that desc */
>> +	return description ? strim(description + 1) : NULL;
>> +}
>> +
>> +static bool is_shell_script(const char *path)
>> +{ /* is this full file path a shell script */
>> +	const char *ext;
>> +
>> +	ext = strrchr(path, '.');
>> +	if (!ext)
>> +		return false;
>> +	if (!strcmp(ext, ".sh")) { /* Has .sh extension */
>> +		if (access(path, R_OK | X_OK) == 0) /* Is executable */
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static bool is_test_script(const char *path, const char *name)
>> +{ /* Is this file in this dir a shell script (for test purposes) */
> 
> If this is a comment for function, place the comment on the top of the
> function.

OK - can do for the others too.

>> +	char filename[PATH_MAX];
>> +
>> +	path__join(filename, sizeof(filename), path, name);
> 
> This patch is not only for refactoring handling test sub folders,
> there have many minor changes, IIUC, here it drops macro
> for_each_shell_test() and is_directory(), etc.
> 
> I am not saying this is wrong, but this is not easy for review.

It's essentially all new code. It didn't go through small stages. The 
moving of logic to this file does in effect re-factor the design and 
code and simplifies other code as well as now supporting recursive 
scanning which is essential to another change you asked for, but there 
were not stages I hid - I never used the forea_each_... macros at all 
and wrote all of the above file in one go and then used its APIs and 
then removed the redundant undused code in the calling file.

>> +	if (!is_shell_script(filename)) return false;
> 
>          if (!is_shell_script(filename))
>                  return false;
> 
>> +	return true;
>> +}
>> +
>> +static char *strdup_check(const char *str)
>> +{ /* Duplicate a string and fall over and die if we run out of memory */
> 
> Place comment on the top of function.
> 
>> +	char *newstr;
>> +
>> +	newstr = strdup(str);
>> +	if (!newstr) {
>> +		pr_err("Out of memory while duplicating test script string\n");
>> +		abort();
>> +	}
>> +	return newstr;
>> +}
>> +
>> +static void append_script(const char *dir, const char *file, const char *desc)
>> +{
>> +	struct script_file *files_tmp;
>> +	size_t files_num_tmp;
>> +	int width;
>> +
>> +	files_num_tmp = files_num + 1;
>> +	if (files_num_tmp < 1) {
> 
> How about below condition checking?
> 
>          if (files_num_tmp >= SIZE_MAX) {

I've always found it easier to not rely on defines to avoid getting them 
wrong (use the wrong defined size for the wrong type - eg size_t ssize_t 
etc.) and thus write things in a way to avoid human error... but I can 
do that.

>> +		pr_err("Too many script files\n");
>> +		abort();
> 
> Can don't use abort() and return error, so upper function can handle
> the error gracefully?
> 
>> +	}
>> +	/* Realloc is good enough, though we could realloc by chunks, not that
>> +	 * anyone will ever measure performance here */
>> +	files_tmp = realloc(files,
>> +			    (files_num_tmp + 1) * sizeof(struct script_file));
> 
>          files = realloc(files,
>                          (files_num_tmp + 1) * sizeof(struct script_file));
> 
> BTW, I don't see any where to free the memory for "files".

The very first comment at the top of the code (after headers) that you 
wanted the format of changed explains this right above the static vars. 
There is no point. This is code for a utility that runs tests and runs 
them once ever and then exits. There is no need for a cleanup/free as 
it's all freed on process exit. It's a singleton design pattern so it 
scans for these test files once ever for the whole run of the tests 
(unlike before it'd scan multiple times with all the I/O overhead and 
syscall costs).

>> +	if (files_tmp == NULL) {
>> +		pr_err("Out of memory while building test list\n");
>> +		abort();
>> +	}
>> +	/* Add file to end and NULL terminate the struct array */
>> +	files = files_tmp;
>> +	files_num = files_num_tmp;
>> +	files[files_num - 1].dir = strdup_check(dir);
>> +	files[files_num - 1].file = strdup_check(file);
>> +	files[files_num - 1].desc = strdup_check(desc);
>> +	files[files_num].dir = NULL;
>> +	files[files_num].file = NULL;
>> +	files[files_num].desc = NULL;
> 
> I personally think here it's over complex for using the last item in the
> array as a redundant item and set NULL to its fields.  We have the
> global variable "files_num", which can be used for checking boundary
> for the array.

See how the code is called. It makes the calling simpler as you don't 
need to get both the array and the num/count. You just get the array and 
iterate until a NULL item. So the calling convention is simplified. 
That's why I did it. It's a very common design pattern that saves some 
complexity at the caller end with the cost of a "null item" overhead. 
Just do ptr++ as you iterate over the files until a null item - much 
simpler calling code.

>> +
>> +	width = strlen(desc); /* Track max width of desc */
>> +	if (width > files_max_width)
>> +		files_max_width = width;
>> +}
>> +
>> +static void append_scripts_in_dir(const char *path)
>> +{
>> +	struct dirent **entlist;
>> +	struct dirent *ent;
>> +	int n_dirs, i;
>> +	char filename[PATH_MAX];
>> +
>> +	/* List files, sorted by alpha */
>> +	n_dirs = scandir(path, &entlist, NULL, alphasort);
>> +	if (n_dirs == -1)
>> +		return;
>> +	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
>> +		if (ent->d_name[0] == '.') continue; /* Skip hidden files */
> 
> Here really need to check '.'?  The function is_shell_script() has
> checked for hidden files.

Skips hidden dirs as this also recurses into sub-dirs unlike before. Yes 
the is_shell_script also checks for '.' - It isn't strictly needed but 
it does "complete" the logic of that function.

> The code format should be:
> 
>                  /* Skip hidden files */
>                  if (ent->d_name[0] == '.')
>                          continue;

OK - can do.

>> +		if (is_test_script(path, ent->d_name)) { /* It's a test */
>> +			char bf[256];
>> +			const char *desc = shell_test__description
>> +				(bf, sizeof(bf), path, ent->d_name);
>> +
>> +			if (desc) /* It has a desc line - valid script */
>> +				append_script(path, ent->d_name, desc);
>> +		} else if (is_directory(path, ent)) { /* Scan the subdir */
>> +			path__join(filename, sizeof(filename),
>> +				   path, ent->d_name);
>> +			append_scripts_in_dir(filename);
>> +		}
>> +	}
>> +	for (i = 0; i < n_dirs; i++) /* Clean up */
>> +		zfree(&entlist[i]);
>> +	free(entlist);
>> +}
>> +
>> +const struct script_file *list_script_files(void)
>> +{
>> +	char path_dir[PATH_MAX];
>> +	const char *path;
>> +
>> +	if (files) return files; /* Singleton - we already know our list */
> 
>          if (files)
>                  return files;
> 
> The rest part of this patch looks good to me.
> 
> I strongly suggest you to consider how to organize the patches with
> better format.  This patch actually finishes below things:
> 
> - Support sub folder searching for shell script (so the key change is
>    using the recursion in append_scripts_in_dir());
> - Refactoring to a common code for iterating testing scripts;
> - Many minor refactoring, like dropping macro for_each_shell_test()
>    and introduces new function is_shell_script().
> 
> Seems every part above is deserved to use a separate patch, which would
> be much easier for review.

It was not written in stages at all but wholesale written as a new file 
to replace the functionality in the previous file that was duplicated 
multiple times (scandir). The new code could also recurse too. I'd have 
to bend over backwards to create an artificial new set of code that uses 
all the old code then iterate it multiple times to do this. It's not how 
it happened.

It should be drastically easier to review this way as you can easily 
just see the old code vanish and how it now calls the new code (and how 
simple it is) and then the whole new code beng called - review it as new 
code. :)

> Thanks,
> Leo
> 
>> +
>> +	path = shell_tests__dir(path_dir, sizeof(path_dir)); /* Walk  dir */
>> +	append_scripts_in_dir(path);
>> +
>> +	return files;
>> +}
>> +
>> +int list_script_max_width(void)
>> +{
>> +	list_script_files(); /* Ensure we have scanned all scriptd */
>> +	return files_max_width;
>> +}
>> diff --git a/tools/perf/tests/builtin-test-list.h b/tools/perf/tests/builtin-test-list.h
>> new file mode 100644
>> index 000000000000..eb81f3aa6683
>> --- /dev/null
>> +++ b/tools/perf/tests/builtin-test-list.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +struct script_file {
>> +	char *dir;
>> +	char *file;
>> +	char *desc;
>> +};
>> +
>> +/* List available script tests to run - singleton - never freed */
>> +const struct script_file *list_script_files(void);
>> +/* Get maximum width of description string */
>> +int list_script_max_width(void);
>> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
>> index 81cf241cd109..7122eae1d98d 100644
>> --- a/tools/perf/tests/builtin-test.c
>> +++ b/tools/perf/tests/builtin-test.c
>> @@ -28,6 +28,8 @@
>>   #include <subcmd/exec-cmd.h>
>>   #include <linux/zalloc.h>
>>   
>> +#include "builtin-test-list.h"
>> +
>>   static bool dont_fork;
>>   
>>   struct test_suite *__weak arch_tests[] = {
>> @@ -274,91 +276,6 @@ static int test_and_print(struct test_suite *t, int subtest)
>>   	return err;
>>   }
>>   
>> -static const char *shell_test__description(char *description, size_t size,
>> -					   const char *path, const char *name)
>> -{
>> -	FILE *fp;
>> -	char filename[PATH_MAX];
>> -	int ch;
>> -
>> -	path__join(filename, sizeof(filename), path, name);
>> -	fp = fopen(filename, "r");
>> -	if (!fp)
>> -		return NULL;
>> -
>> -	/* Skip shebang */
>> -	do {
>> -		ch = fgetc(fp);
>> -	} while (ch != EOF && ch != '\n');
>> -
>> -	description = fgets(description, size, fp);
>> -	fclose(fp);
>> -
>> -	return description ? strim(description + 1) : NULL;
>> -}
>> -
>> -#define for_each_shell_test(entlist, nr, base, ent)	                \
>> -	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
>> -		if (!is_directory(base, ent) && \
>> -			is_executable_file(base, ent) && \
>> -			ent->d_name[0] != '.')
>> -
>> -static const char *shell_tests__dir(char *path, size_t size)
>> -{
>> -	const char *devel_dirs[] = { "./tools/perf/tests", "./tests", };
>> -        char *exec_path;
>> -	unsigned int i;
>> -
>> -	for (i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
>> -		struct stat st;
>> -		if (!lstat(devel_dirs[i], &st)) {
>> -			scnprintf(path, size, "%s/shell", devel_dirs[i]);
>> -			if (!lstat(devel_dirs[i], &st))
>> -				return path;
>> -		}
>> -	}
>> -
>> -        /* Then installed path. */
>> -        exec_path = get_argv_exec_path();
>> -        scnprintf(path, size, "%s/tests/shell", exec_path);
>> -	free(exec_path);
>> -	return path;
>> -}
>> -
>> -static int shell_tests__max_desc_width(void)
>> -{
>> -	struct dirent **entlist;
>> -	struct dirent *ent;
>> -	int n_dirs, e;
>> -	char path_dir[PATH_MAX];
>> -	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
>> -	int width = 0;
>> -
>> -	if (path == NULL)
>> -		return -1;
>> -
>> -	n_dirs = scandir(path, &entlist, NULL, alphasort);
>> -	if (n_dirs == -1)
>> -		return -1;
>> -
>> -	for_each_shell_test(entlist, n_dirs, path, ent) {
>> -		char bf[256];
>> -		const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
>> -
>> -		if (desc) {
>> -			int len = strlen(desc);
>> -
>> -			if (width < len)
>> -				width = len;
>> -		}
>> -	}
>> -
>> -	for (e = 0; e < n_dirs; e++)
>> -		zfree(&entlist[e]);
>> -	free(entlist);
>> -	return width;
>> -}
>> -
>>   struct shell_test {
>>   	const char *dir;
>>   	const char *file;
>> @@ -385,33 +302,17 @@ static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
>>   static int run_shell_tests(int argc, const char *argv[], int i, int width,
>>   				struct intlist *skiplist)
>>   {
>> -	struct dirent **entlist;
>> -	struct dirent *ent;
>> -	int n_dirs, e;
>> -	char path_dir[PATH_MAX];
>> -	struct shell_test st = {
>> -		.dir = shell_tests__dir(path_dir, sizeof(path_dir)),
>> -	};
>> -
>> -	if (st.dir == NULL)
>> -		return -1;
>> +	struct shell_test st;
>> +	const struct script_file *files, *file;
>>   
>> -	n_dirs = scandir(st.dir, &entlist, NULL, alphasort);
>> -	if (n_dirs == -1) {
>> -		pr_err("failed to open shell test directory: %s\n",
>> -			st.dir);
>> -		return -1;
>> -	}
>> -
>> -	for_each_shell_test(entlist, n_dirs, st.dir, ent) {
>> +	files = list_script_files();
>> +	if (!files)
>> +		return 0;
>> +	for (file = files; file->dir; file++) {
>>   		int curr = i++;
>> -		char desc[256];
>>   		struct test_case test_cases[] = {
>>   			{
>> -				.desc = shell_test__description(desc,
>> -								sizeof(desc),
>> -								st.dir,
>> -								ent->d_name),
>> +				.desc = file->desc,
>>   				.run_case = shell_test__run,
>>   			},
>>   			{ .name = NULL, }
>> @@ -421,12 +322,13 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
>>   			.test_cases = test_cases,
>>   			.priv = &st,
>>   		};
>> +		st.dir = file->dir;
>>   
>>   		if (test_suite.desc == NULL ||
>>   		    !perf_test__matches(test_suite.desc, curr, argc, argv))
>>   			continue;
>>   
>> -		st.file = ent->d_name;
>> +		st.file = file->file;
>>   		pr_info("%3d: %-*s:", i, width, test_suite.desc);
>>   
>>   		if (intlist__find(skiplist, i)) {
>> @@ -436,10 +338,6 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
>>   
>>   		test_and_print(&test_suite, 0);
>>   	}
>> -
>> -	for (e = 0; e < n_dirs; e++)
>> -		zfree(&entlist[e]);
>> -	free(entlist);
>>   	return 0;
>>   }
>>   
>> @@ -448,7 +346,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>>   	struct test_suite *t;
>>   	unsigned int j, k;
>>   	int i = 0;
>> -	int width = shell_tests__max_desc_width();
>> +	int width = list_script_max_width();
>>   
>>   	for_each_test(j, k, t) {
>>   		int len = strlen(test_description(t, -1));
>> @@ -529,36 +427,22 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>>   
>>   static int perf_test__list_shell(int argc, const char **argv, int i)
>>   {
>> -	struct dirent **entlist;
>> -	struct dirent *ent;
>> -	int n_dirs, e;
>> -	char path_dir[PATH_MAX];
>> -	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
>> -
>> -	if (path == NULL)
>> -		return -1;
>> +	const struct script_file *files, *file;
>>   
>> -	n_dirs = scandir(path, &entlist, NULL, alphasort);
>> -	if (n_dirs == -1)
>> -		return -1;
>> -
>> -	for_each_shell_test(entlist, n_dirs, path, ent) {
>> +	files = list_script_files();
>> +	if (!files)
>> +		return 0;
>> +	for (file = files; file->dir; file++) {
>>   		int curr = i++;
>> -		char bf[256];
>>   		struct test_suite t = {
>> -			.desc = shell_test__description(bf, sizeof(bf), path, ent->d_name),
>> +			.desc = file->desc
>>   		};
>>   
>>   		if (!perf_test__matches(t.desc, curr, argc, argv))
>>   			continue;
>>   
>>   		pr_info("%3d: %s\n", i, t.desc);
>> -
>>   	}
>> -
>> -	for (e = 0; e < n_dirs; e++)
>> -		zfree(&entlist[e]);
>> -	free(entlist);
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.32.0
>>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
