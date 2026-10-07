Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53223386559;
	Wed,  7 Oct 2026 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410985; cv=none; b=btbfDfSjl76OrmhtiEF6YvDwjqeUbZx8in40q4Sw1TyCF3iFw7x7auePbynFlG/x6bltkFuB+uXZYqHweI8+Zd06dAvWcsy/casQz/nXxnVfUpE0F/QKyRhc/c2V9VMdMA89fFR9U9ZDQBRZ+oDSggr0229BzbpaW74lwrElaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410985; c=relaxed/simple;
	bh=5TisVoXwwDiefmk+wCHW5gpii6e3d1UNsnYdX8jOyLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0JS7lFcYupg87SAb4EJNDfl4dkKy3XNjvJ4KmdDcOq/XaDHG0N785EGfro9d6EN18WYUql6e8hI4arwlvH/R4BK+cMJmBM3uXST1ywTqpmGYbp+p8/Ruv0S1GKoJ7nqOpjDn8qWjny4mWmQKQBx89sOGjxEkO2C0OWcdLQKNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVIYNEdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVIYNEdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8BD1F000FF;
	Wed,  7 Oct 2026 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791410984;
	bh=DqY+VW/M6ltcBBVmINQ3iEiw2ym5es6Y1ar3c//dFWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GVIYNEdH7zu758T7J7JokKV83fs+sMKf6Ta7g4EyPuRjGk1jA0C+qDCwKuQAivuPg
	 QidKNBhm6TUWfwc9jpFYkF2qKmwDQ2weT0kdu6xOcQi0mxEyswDsu7xk+tPPetHAlh
	 NXoVdhqWjUjzFlEJiVdYiEOwFlqyxKIVkSIvEHl2zVRbRH1iVx/E8Qbf888xqWXmaH
	 9vxw3iYqT8KGSfE8vBgw1QXSa+qUWlc/HVvMQqUXOS3jokrHqC8yRk9og/0uRkZmhc
	 5LljwGQZdP+hlWixe189Vh2FXYVWucPyVM/xeV4mW5OYmWSjhm7Y62IyuUHzLleDvX
	 HBmXXmEzJrr+g==
Date: Wed, 7 Oct 2026 15:09:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] perf dso: Allow reading DSO data from an explicit
 file
Message-ID: <asbDJrY97tRqoPaR@google.com>
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-2-165dceb2b049@uber.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005-perf-symbol-memory-send-v5-2-165dceb2b049@uber.com>

On Mon, Oct 05, 2026 at 10:30:32AM -0700, Alireza Haghdoost via B4 Relay wrote:
> From: Alireza Haghdoost <haghdoost@uber.com>
> 
> The DSO data cache derives the file to open from the DSO's binary type,
> which can resolve to the runtime image rather than the file a symbol
> table was read from. The lazy symbol loader added later in this series
> reads symbol names at string-table offsets in the file the symbol table
> came from. With split debuginfo, the data cache would apply those
> debuginfo offsets to the runtime image.
> 
> This patch adds dso__data_set_path() so a DSO can be configured to read
> from one exact file while keeping the data cache's descriptor eviction
> and reopening. The path is used only when the data cache opens the file;
> dso__get_filename() and its debuginfo callers are unchanged. Such DSOs
> may be owned privately rather than being part of a dsos collection, so
> the patch also drops the assertion that every opened data DSO is in one.

I'm afraid it may confuse perf annotate where it needs to read binary
data from a file as well as lazy-load symbols from another.  I'm working
on cleaning up the relevant code and I'm reluctant to add 'path' to the
dso.  We have too many names for a DSO already. :)

For a short term solution, I'm afraid you need to use dso__get_filename()
with symtab_type and read the file without using the data cache API.

In the long term, I think it needs to pass a binary type arguments to
read data from the dso.  It'd clarify what users want to read and
support different files at the same time.

Thanks,
Namhyung

> 
> Add a DSO data test that reads through an explicit path, closes the
> descriptor, and reads an uncached offset to exercise reopening.
> 
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---
>  tools/perf/tests/dso-data.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dso.c       | 30 ++++++++++++++++++++++++++----
>  tools/perf/util/dso.h       |  2 ++
>  3 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> index 46bc3f597260..fbfb2f08d3ba 100644
> --- a/tools/perf/tests/dso-data.c
> +++ b/tools/perf/tests/dso-data.c
> @@ -393,11 +393,53 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
>  	return 0;
>  }
>  
> +static int test__dso_data_path(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +{
> +	u8 expect[10] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
> +	char *file = test_file(TEST_FILE_SIZE);
> +	struct dso *dso;
> +	long nr, nr_end;
> +	u8 buf[10];
> +
> +	TEST_ASSERT_VAL("No test file", file);
> +	nr = open_files_cnt();
> +
> +	/*
> +	 * The DSO name does not exist and the DSO is not in a dsos
> +	 * collection; reads must come from the configured path.
> +	 */
> +	dso = dso__new("/nonexistent/perf-test-dso-data-path");
> +	TEST_ASSERT_VAL("Failed to create dso", dso);
> +	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
> +	TEST_ASSERT_VAL("Failed to set path", !dso__data_set_path(dso, file));
> +
> +	TEST_ASSERT_VAL("Wrong size",
> +			dso__data_read_offset(dso, NULL, 10, buf, 10) == 10);
> +	TEST_ASSERT_VAL("Wrong data", !memcmp(buf, expect, 10));
> +
> +	/* An uncached offset after close must reopen the configured path. */
> +	dso__data_close(dso);
> +	memset(buf, 0, sizeof(buf));
> +	TEST_ASSERT_VAL("Wrong size after reopen",
> +			dso__data_read_offset(dso, NULL, DSO__DATA_CACHE_SIZE * 2 + 10,
> +					      buf, 10) == 10);
> +	TEST_ASSERT_VAL("Wrong data after reopen",
> +			buf[0] == (DSO__DATA_CACHE_SIZE * 2 + 10) % 10);
> +
> +	dso__data_close(dso);
> +	dso__put(dso);
> +	unlink(file);
> +
> +	nr_end = open_files_cnt();
> +	TEST_ASSERT_VAL("failed leaking files", nr == nr_end);
> +	return 0;
> +}
>  
>  static struct test_case tests__dso_data[] = {
>  	TEST_CASE("read", dso_data),
>  	TEST_CASE("cache", dso_data_cache),
>  	TEST_CASE("reopen", dso_data_reopen),
> +	TEST_CASE("explicit path", dso_data_path),
>  	{	.name = NULL, }
>  };
>  
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index d3017c82ffb5..5c4872810ada 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -547,8 +547,6 @@ static void dso__list_add(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_o
>  #ifdef REFCNT_CHECKING
>  	dso__data(dso)->dso = dso__get(dso);
>  #endif
> -	/* Assume the dso is part of dsos, hence the optional reference count above. */
> -	assert(dso__dsos(dso));
>  	dso__data_open_cnt++;
>  }
>  
> @@ -678,8 +676,11 @@ static int __open_dso(struct dso *dso, struct machine *machine)
>  
>  	mutex_lock(dso__lock(dso));
>  
> -	name = dso__get_filename(dso, machine ? machine->root_dir : "", &decomp,
> -				 dso__binary_type(dso));
> +	if (dso__data(dso)->path)
> +		name = strdup(dso__data(dso)->path);
> +	else
> +		name = dso__get_filename(dso, machine ? machine->root_dir : "",
> +					 &decomp, dso__binary_type(dso));
>  	if (name) {
>  		fd = do_open(name);
>  	} else {
> @@ -833,6 +834,26 @@ void dso__data_close(struct dso *dso)
>  	mutex_unlock(dso__data_open_lock());
>  }
>  
> +/**
> + * dso__data_set_path - Read @dso's data from an explicit file
> + * @dso: dso object
> + * @path: file to open instead of the path derived from the binary type
> + *
> + * Used when the data must come from one specific file, such as the separate
> + * debuginfo file that a symbol table was read from. Must be called before any
> + * data is read, as already cached data is not invalidated.
> + */
> +int dso__data_set_path(struct dso *dso, const char *path)
> +{
> +	char *new_path = strdup(path);
> +
> +	if (!new_path)
> +		return -ENOMEM;
> +	free(dso__data(dso)->path);
> +	dso__data(dso)->path = new_path;
> +	return 0;
> +}
> +
>  static void try_to_open_dso(struct dso *dso, struct machine *machine)
>  	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
>  {
> @@ -1783,6 +1804,7 @@ void dso__delete(struct dso *dso)
>  	dso__data_close(dso);
>  	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
>  	dso_cache__free(dso);
> +	zfree(&RC_CHK_ACCESS(dso)->data.path);
>  	dso__free_a2l(dso);
>  	dso__free_a2l_libbfd(dso);
>  	dso__free_libdw(dso);
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 3f08d45e7f53..7bcd5ec0c312 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -264,6 +264,7 @@ struct dso_data {
>  #ifdef REFCNT_CHECKING
>  	struct dso	 *dso;
>  #endif
> +	char		 *path;
>  	int		 fd;
>  	int		 status;
>  	u32		 status_seen;
> @@ -921,6 +922,7 @@ bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
>  	EXCLUSIVE_TRYLOCK_FUNCTION(true, _dso__data_open_lock);
>  void dso__data_put_fd(struct dso *dso) UNLOCK_FUNCTION(_dso__data_open_lock);
>  void dso__data_close(struct dso *dso) LOCKS_EXCLUDED(_dso__data_open_lock);
> +int dso__data_set_path(struct dso *dso, const char *path);
>  
>  int dso__data_file_size(struct dso *dso, struct machine *machine);
>  off_t dso__data_size(struct dso *dso, struct machine *machine);
> 
> -- 
> Git-157)
> 
> 
