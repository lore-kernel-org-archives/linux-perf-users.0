Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E837C115
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841927; cv=pass; b=Y7FfXbwEHN3uI2nbw1IcW1mBDh+9s48ioG4fUxrRRRbgtb8OZ8QYnMVkVh/S3PXS/ytn2cjIpJQfMcbVFjqCQ8o6cvCpgQrs8WiqNQhdtcQs33rvZ30hB78MPvmEVa2HB6IzBuNKy+hiXG00bS+tQkMNx3w0qqG9jKRVfCbGP6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841927; c=relaxed/simple;
	bh=DIL5UuZhGTA2pRNXRbjhs4HWRHo7MrRLOSBM7IepAYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W09eLhUzFnzKCqFY7ltxKCSRA79FnUIZhZOM5cj5lINc6GRQnbW82u2f6tKVPgExm5KiPZKbcoPMQMYqwXb1BqOouoxit5Y2sjvzkoXc0Uv5AaaFwDqMP5kPQZRDHCV+rIIbkr+LdaOfYPGmwqu63qYrG/Q/XB4xW1voD4f0tuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vaiuofci; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vaiuofci"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533202fe429so543891cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 14:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791841925; cv=none;
        d=google.com; s=arc-20260327;
        b=ay6v1oHMo3nu+MlTKV79bLgiEP6FauT8u2Xx41cgU4jAz5Q7pzg1rGcTT7lJ8RaeOr
         YQUBxZ1MxD3Pyh72ADYZ73aQ4cqpvowlyO5rMn/ehqCWD+H3/a79ponZej4mD2RTH3Eu
         7myMGJuiEao0Ip/UCxieGn/tfoWpEZTCx2CfTRlFeskCvpg/Z6pTlUyZRf3qImXpLfw2
         Tna00hgS0WXv6l8Js4PYo6BU98L5tIvARiRs2mK6R9fQTpugfR8FOgInOX7ZgYwP5zra
         O7IiTpkPC36d8CA5f2MYIYrUJsr9lYsjao3GZnKNj7NsqgkQLDMEFPnCFCHO//KLgjKY
         9SrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YLoAoEeE0ibBzPThB0BLma4hgq+eUQQ3jaPTysHvBC0=;
        fh=x5JtiLXzRQftxplt72MPwtwSOxBMAqjsO8qC2E58asA=;
        b=oYsospcdcOJXFNEeD2sodbOoV2qRTVk4OvKE72vF5Kfo2N2UrMVfCE4OteeFcSwmTo
         oG+J2WsuIWICAAAR3m5C+YyzsYpVoDXSGwlZQz2Yc5of6l7n78nA6Zm58W0tisl8yium
         kzBOmMcmpdvIjksqWnevKpUBu2l1GD1W5ivXk3ABkZGPszvYn6w/7WOAvcUgnPIBrmYk
         nvxPKqMhF/EncdpUUB80mVcyX23v9NVTCWmYS+yZBTlFnAWbd8WuT3lpZTQurn4s1nzR
         GmvWiOSmrUlyUnj0CzOxPsInnpAbwENpt+iUOoq8QSD2TmSV/tK2G0CrK0086YWx8ZFp
         j8Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791841925; x=1792446725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YLoAoEeE0ibBzPThB0BLma4hgq+eUQQ3jaPTysHvBC0=;
        b=VaiuofciM1NPp/ND4T0HN6N92O1EY4zQZrZ5VmQbuV7GqZMSiKFsj0LVq8tWIyhdUH
         IepGmxX75BmT5g1TkHEI7AQj4ZIddR0m8++ndvpbaeyZ10mR7hW58Jko4q6ga3+OpBvX
         T4HyEIu2fscD5r51TgUVZ3bZQM9wmoLNlE5Xj8bcztg16g+BdYH4j4T7+20vE34GR4Nr
         b23bYajCDA5skuwvcyWVBJ2zGGcaQGp7F736F4SOty/tKGm303/izuwwLZrgB/Z0ouO4
         UX6HGYSfSQKeJC65z8JXDdENqlro6e/zUvjtweyoKNvRVNX4Ipg7wx9KSZ3RE4EMywZt
         i6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841925; x=1792446725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLoAoEeE0ibBzPThB0BLma4hgq+eUQQ3jaPTysHvBC0=;
        b=IyTtgc4lV4Jl/rVmWzEkeijTAnRv2v6Teiod6mjviajqokGCfnPHIpqjRzwAjZSotP
         hQ4A1/86+svNPeYZjc0Tqwh39LzN5eYLjoy6AK1GPoogpxsWsvyUZ24gXA311fy+XEX0
         nw0CI5ATsyM7mwOaTVgqAhojD5mfvtBxFZdYFz1NgL0TDWmNSUfw63/QVUvMsbwIx9xm
         bJExVjEVve5/DNYIIOrOhICb6QP+fbdQlmH5px+Vs4ePN1QTusIk0mpy7wFgIhEFJXgk
         rS9X0w4oCEgGLSr9yY5zbSyQPY+uihHH5pH28tmn2jzfoNoya0EVqsrG+wDesgb0W1GY
         hmFg==
X-Forwarded-Encrypted: i=1; AKwUvByEKqJS8izFOBhysEuI3hI9Xd3PdDN0xFbutJmDLrBomUkJeLr61j1KHP+t+bzsL4CHycQOoG6akds8YZUiC5gq@vger.kernel.org
X-Gm-Message-State: AFq9FYKIRVk7n+RjnhhdkCvEWmP9rccAaNANrHuZiLFHegwberGL8AhA
	fhivRExPqvABPEb86UaTNxzptq+Fz2qJscTk9Dkas2cOpDAPtQ+YtsOsduIbtp+Hc184qOvVYNR
	OYr6TfnM6UBnhjXX2lYTp+E6axmlyBhfuRedhkGRC
X-Gm-Gg: AYBFou2d4EvgMCUo8Z0D02Mx84s5aMlHZ7hrVZ2TC3jIH9JaAT1+E/Lns19JJxSxIwn
	BeCp8L5F8tENhMwqnHPw6D/dftw1pQ9NIw+HlbMzJNA2XWAPcBcHOJUmbBLiP3IoTiQR8kWFd1/
	1wG+eR47D/U+/rCjU7/aGYqYF/Ym4pcyxI+vvUwSu2MSjKCcKbaUr1ZM+PcvZxO5+vr9eVtwQtK
	PLiF8Xz6vylMP9PoitCwHbi8+wQfdlBgn+nmCIE69u54ghBkyIfBbmQ0VmMhr52sd7k6zPQ7qSc
	PhjO9JL6/CIeiPL83npk0VPSa7BQbxfH1YVvqM9t731pv7tMAdyrMndu5d/zEEHmfHq+msLD4BR
	cuOQDbdoYOg==
X-Received: by 2002:a05:622a:345:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-535b4f9b8d1mr34243711cf.14.1791841923948; Mon, 12 Oct 2026
 14:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012053013.14378-1-namhyung@kernel.org> <20261012053013.14378-4-namhyung@kernel.org>
In-Reply-To: <20261012053013.14378-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 14:51:52 -0700
X-Gm-Features: AclHuK8fSmSW9prYIWpNexYiVkZwA9i8SN5Rf1NNY9lV-sUOfaw0J3zWzFUeo0c
Message-ID: <CAP-5=fW1SSoyGKjaujZewF=b3rJ-0vp4kJ-friWNzOQWk+ki5A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf test: Update PE file test for other locations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 10:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The test__pe_file_parsing() expects the test is in the tools/perf
> directory, but it could be root or a separate build directory.  Let's
> update the logic to try other paths like in the shell_tests__dir_fd().
>
> Also add some debug messages to inform users why it's skipped.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/pe-file-parsing.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-fil=
e-parsing.c
> index 3979f38bf127c218..78dae7e43603b9f8 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -74,10 +74,17 @@ static int test__pe_file_parsing(struct test_suite *t=
est __maybe_unused,
>  {
>         struct stat st;
>         char path_dir[PATH_MAX];
> +       static const char * const tests_dirs[] =3D {
> +               "./tools/perf/tests",
> +               "./tests",
> +               "./source/tests"

I'm not sure where "source/tests" comes from?
nit: could we add the exec_path case to the list?

Thanks,
Ian

> +       };
>
>         /* First try development tree tests. */
> -       if (!lstat("./tests", &st))
> -               return run_dir("./tests");
> +       for (size_t i =3D 0; i < ARRAY_SIZE(tests_dirs); ++i) {
> +               if (!lstat(tests_dirs[i], &st))
> +                       return run_dir(tests_dirs[i]);
> +       }
>
>         /* Then installed path. */
>         snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());
> @@ -85,6 +92,7 @@ static int test__pe_file_parsing(struct test_suite *tes=
t __maybe_unused,
>         if (!lstat(path_dir, &st))
>                 return run_dir(path_dir);
>
> +       pr_debug("cannot find the tests directory\n");
>         return TEST_SKIP;
>  }
>
> @@ -93,6 +101,7 @@ static int test__pe_file_parsing(struct test_suite *te=
st __maybe_unused,
>  static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
>                           int subtest __maybe_unused)
>  {
> +       pr_debug("libbfd is not available\n");
>         return TEST_SKIP;
>  }
>
> --
> 2.55.0
>
