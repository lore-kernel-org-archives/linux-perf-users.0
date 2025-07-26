Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E028682
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753510914; cv=none; b=rvwxD2NnEzmWXZyg6fuhsaRRghuDWXIAaZYz7Azilc0cuwFMqALQVFyyStkmcrjKuT+hxwa2XX7+m/TORGzEQ6N1o37usxN2hQaGzUObevpFP3TKJ6HrsmNiFtQHk94IDEpQQHQJFVxM7+3ah+XQ0caI6Hie95paszBLNeL/MoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753510914; c=relaxed/simple;
	bh=hsCxdxCbPd+gIOTViUigISUb9oD8yxMiDkHlzsPlKKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMiXn5LQ67gkiqhnScpkUZ6U9BObyivkOx+lXpP0XkopFchUrTlA0x4sILb3IPhVPEXGx963ecA/880JokeFdBRJ8lLfHqDClX1764/puqHWlX5i/Oboyf3e3wqWsnPe9qp8NicGQZ1JAHclwLwuxIK4RpUeoS3B1nLLlBwI+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZmXRCtC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZmXRCtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C593BC4CEED;
	Sat, 26 Jul 2025 06:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753510914;
	bh=hsCxdxCbPd+gIOTViUigISUb9oD8yxMiDkHlzsPlKKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZmXRCtCCT1Ko7rklQS6vemCFLvy66/NM+b0MguRJiDlzgte4ENSpQuEo7siKu7AE
	 l2j1fFC+main8VHAYzv8ngJIWos8vkqcRurYW9hDJm/Nz2E3NOqVtjvvYNWRDIypKh
	 rY2QuOg3okksBcCEdJMZ5oNv94gwTuArkyOoMT6Ymz4dy7OMGfclXnUkskbHV7CqWC
	 R8O+mG+/4wmRm66kvdlp30l4TuQvvQa8SON7lZYVorV6qtJ1YTzzxIFFCvuVBNGVqy
	 iWlAK7icOMrkCRbYiRPCcqVUV/kCEDmoK1c+3TT5GV1aY0XjhNmMxMTIA5EokxEtWr
	 fgk6Yj5egWKjA==
Date: Fri, 25 Jul 2025 23:21:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jakub Brnak <jbrnak@redhat.com>
Cc: vmolnaro@redhat.com, acme@kernel.org, acme@redhat.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com
Subject: Re: [PATCH v3 6/7] perf test: Format log directories for shell tests
Message-ID: <aIR0AH_-y-jurGZq@google.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
 <20250721132642.40906-7-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721132642.40906-7-jbrnak@redhat.com>

On Mon, Jul 21, 2025 at 03:26:41PM +0200, Jakub Brnak wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> The name of the log directory can be taken from the test suite
> description, which possibly could contain whitespace characters. This
> can cause further issues if the name is not quoted correctly.
> 
> Replace the whitespace characters with an underscore to prevent the
> possible issues caused by the name splitting.
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 89b180798224..9cb0788d3307 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -283,6 +283,21 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
>  	return t->test_cases[test_case].exclusive;
>  }
>  
> +/* Replace non-alphanumeric characters with _ */
> +static void check_dir_name(const char *src, char *dst)

It's not about just checking the name.  Maybe replace_dir_name()?

Thanks,
Namhyung

> +{
> +	size_t i;
> +	size_t len = strlen(src);
> +
> +	for (i = 0; i < len; i++) {
> +		if (!isalnum(src[i]))
> +			dst[i] = '_';
> +		else
> +			dst[i] = src[i];
> +	}
> +	dst[i] = '\0';
> +}
> +
>  static int delete_file(const char *fpath, const struct stat *sb __maybe_unused,
>  						 int typeflag, struct FTW *ftwbuf)
>  {
> @@ -328,10 +343,12 @@ static bool create_logs(struct test_suite *t, int pass){
>  
>  static char *setup_shell_logs(const char *name)
>  {
> -	char template[PATH_MAX];
> +	char template[PATH_MAX], valid_name[strlen(name)+1];
>  	char *temp_dir;
>  
> -	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name) < 0) {
> +	check_dir_name(name, valid_name);
> +
> +	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", valid_name) < 0) {

It'd be better to do snprintf() first and replace the name so that it
doesn't add the valid_name buffer.

Thanks,
Namhyung


>  		pr_err("Failed to create log dir template");
>  		return NULL; /* Skip the testsuite */
>  	}
> -- 
> 2.50.1
> 
