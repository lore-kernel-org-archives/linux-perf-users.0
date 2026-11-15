Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794779430;
	b=PYydba3GlXv6xs834mFlx9DVuZoCkba8CXQUXjUOdpEUdwJW5QCNTej1a+sX/J5+WzXB
	 wm+ldgZQNWMkcjxD0ptAGjFDSZhL3bEqLV16PrqhjJkLqZjRLQRTxkiUZzO/sP3uRy1ZI
	 WxoWl/G11G+QtD0ebayhPMDXoShw2OS35DPpxq2qIwdAesvY7QNZEf8FzZkn2Tq2AjOKl
	 wnCLE9dpiravBQwKINI49AgqeOdzj5czGiDgNPSqk1x765EKrGj8aWlrwHb18ZUpiXio5
	 aUlNAl1c+Z3rUu9FFB78+ostFiINpMDOiJMrfJEpqnz2xc5/sk3nMXeYU7C/cuoMcHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IXU62tDqDlPa8WP58YWeZoAMWcu6GI1CQ2+oK0ofgos=;
	b=4tnLRFVN34niZJJQcJiYwQAVHJG67AH9sB+sm+/+FqH+X9KugLS34kYrmrpfHiHPVqdy
	 jCB2viU9/OR9fKNaFYgxi/5ssNOZsUsBywOCb+7/6qY3J38IfJ7+itEMoqb11ouSFKsGQ
	 yNFyhLnNIlvfOQneek98cRfU/kX8Ong5MFlXg6Dz3+xiTxIJwbXe/CPUGLSZPL+KN8xOz
	 ShFej1np//hkzfgjCEOglGT1Rj1YbfQo2tKoxEYWR4oV6vBJz3JiM0AkwVLGLwwyfv4v9
	 WpMiPDOlvbQ9QiXJaQiZGBi2sb/Cu5/d2C10YZEcnjY5KyTt/VDmTe7irFs5hOf5DAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y4j8k5Uz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4BD606A332
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 21:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4BD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y4j8k5Uz
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55be673e029so211221cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:50:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794779429; cv=none;
        d=google.com; s=arc-20260327;
        b=dYz9B5wL4Z4GPehbm21t0bMumlgWAvGFzWrrAaRW3X3FS6aVDcIZj58+wpcVRmRnrN
         9KcM66eOCja2mtOZrSWJYNOgwgPQSmqWqiUgUE6oTbOWQt2LJeB7uAD/4UU+fV/3Cv0Q
         u+ul4lyYjF8WODDNf/UCwHkMOrp3I/oq7qsC7WzU9jH5CJ2hs7eWOAycArVhzt5A4N3P
         hanfIOwjhY7DHaIIk5TpqXEvau9wQISdOLoBU0xR+YLAyZ40hQZjEIR9IE+3SO+qFUm3
         OJHgb8+UIll+xQQaadiU5Udpbn0c4v16yRC3lm555SXClqcsBdgOxtkKuJoNuMVVPHIF
         f2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXU62tDqDlPa8WP58YWeZoAMWcu6GI1CQ2+oK0ofgos=;
        fh=BawwGdpgQbZzuxuyEAZdou1xNONX1oL8LuhrNgMFq0c=;
        b=eymp2CBX7WdIJMTxsHG6DdBtCTIae/J66EPRnzsqadMhnXKBTnp2RGVcgkBD7f9nWh
         A5VoYnO4MeBb1TF1isW3sPZXBcSB2kIiJnJkrgUpkt/6g2PzOrV3jxzA6zArjzOyDYIl
         +rgmsROZ1hHsLZl7VES3NjVEsMrHHoUi4aly3v5OBSjscIKzJOhEMFNrOd5731s2LdS7
         a0uaeyOYWf+VU6tz/s1Fj+vyjqXBQnsgouBSwFQpvGuuUx45qfIPi71+iEkCFnU8Exv9
         vihFLasPUsED1SsNraQ2kf0LiR/l/36EnUlzG5g/JF6dbjetoFwFe64XYxOg+Sxuz5It
         wSkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794779429; x=1795384229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IXU62tDqDlPa8WP58YWeZoAMWcu6GI1CQ2+oK0ofgos=;
        b=Y4j8k5UzHH28Gndkeb1c4qa8DdTS+g7kJdR6p7G5unP6DFNaIyE/mEmxz8ne/dQlWW
         0ywpQoswLpJMR6G9MTbrwoN0geyLYn/5uC481qwXmSOOl8O5BHcY67HvX+U08/YCsm/3
         eVcC5kz+02L+Tmlm3DlgY3G7++9agy6du7/F5TfDJ/TDY5DW59ZgA/ZuIfdlRpY+MbLF
         mPNTiZZD8I7uhWkzMmFj+nEuVBeC9tM2x88MjRswHm6OYPy8gOujFlQ99o8l+X/oPRBv
         26ITE8sDbejsVFDlIkWci4CMw5SGquelkrRAvMXwH/vGY0n3TZz9H5IToWP8aAbcd81x
         2umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779429; x=1795384229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXU62tDqDlPa8WP58YWeZoAMWcu6GI1CQ2+oK0ofgos=;
        b=BvDd9zSaIpFU+TXvFfifh/1FJ2aPincGIxhAkdVZSVOMdipE11m+uNj+g4/EpiggDK
         8Id5ls8LK7uvXBx+ul7Hn0QMynbYhKHJYQTc+hLVBRm1p7+/ksFgnNZAHxwHFgzOA6Rf
         hrZYGRAuVz4QE7iOgJxGA9LCBv+XZeKzKpct3DhzSnJNPkM/kusjdlv3PhXh1zbO6x/R
         m2Zdi7r7FGsdZk7lVhMcU7Tfk1X1Ex2HLpeRHG8BaayQ5egmZLL8sw2RQjDHHz4vfRpO
         gsy7s+McPOur+kORSk2Nojt+NgmNau+/AnZZ/lrA4WOzYsP4eAbUAoZth4fN3fzWI9jm
         ztXw==
X-Forwarded-Encrypted: i=1; AL+hErGwzV0zwTVwPaxPwyfegbzo2G+OEzT6qU+fsmaM+kXt5UDgtSnMQKmCSQJHL+s7jska0oY0AO5x7OJfBAhSNsAz@vger.kernel.org
X-Gm-Message-State: APuU4Z/mkNos7tOCKkm+9qybYWp8HKUPLfjATD1iGwbFGMpXeT7w+gCX
	zw2LJmrRQaiTtQ8NEzAmfO+e1FNpkA30zB+X9nkYdzRMMegH2/DngjsuKvR7Esq5YBnPpwba+tY
	+yr2bEf4/WZRIMhOoDGf/UKe5usY1rboyktqvS+ak
X-Gm-Gg: AYBFou0MMhDMmX+pXpdA54m3xIfoPqXJtrzdm2RtZY6/gw5somXXOv844tR8A9RYA0C
	svOhxMLFnozLamekOn0VNSV9a05pU3qRYr7XJ7Plj9/J3JsDL7THgWOOzkO4i38kopiTC7vyM1q
	FjWfW9qOAebypC8MTVaTQF8gQt2KlLwgfhkK94+gBcycrX7M/NJheUDz3t+3NWqa/JApKk8H6XU
	HN7moL/OX1Hdryo7VX3aePsNUuw5MvbL7OG5GtOnjoyhStigSukUtvn4j7O1tXLdKI9tsF3dJKN
	wY87w639nHqAtQsRPPQvSPX+KcLw6SYJZL5zEsGE2pbzkGoJNAzFB3hxhrf5wQzjRP9inzqQQlL
	ytWCw+Tqwl97HYvSTlkdcOQS+oaUFGRQgxC1/
X-Received: by 2002:a05:622a:260f:b0:535:30a:76c7 with SMTP id
 d75a77b69052e-55c469d0cdamr27769951cf.3.1794779428083; Sun, 15 Nov 2026
 13:50:28 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115014102.2879372-1-acme@kernel.org> <20261115014102.2879372-11-acme@kernel.org>
In-Reply-To: <20261115014102.2879372-11-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Nov 2026 13:50:17 -0800
X-Gm-Features: AclHuK8mtb7OHEdWaioT9vcHYZkKdQOkvKFCVhQFs0OYc4w9wKMgClYreMyBMqA
Message-ID: <CAP-5=fVp0LULSbnKJw4OOdN++FCmD-kPBbyOQoN1A+O7SSRNPw@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] perf tests: Fix the Intel PT virtual LBR check
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 5:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> The record this check uses writes aux samples, and with the single data
> page the other tests ask for they are lost:
>
>   Warning: Processed 29 samples and lost 100.00%
>
> so no branches are decoded and the check fails with "Failed with virtual
> lbr".  Record with 4 data pages and 128 auxtrace pages: the same trace
> decodes 64 branches and still fits the mlock budget.
>
> Require the python perf module to provide session, not just to be
> importable: a perf whose python bindings are not found can pick up an
> unrelated module and fail with
>
>   Error processing events: module 'perf' has no attribute 'session'
>
> instead of skipping the subtest.
>
> Detected building perf on fedora:44 on the runner with Intel PT hardware,
> where the subtest failed with "Failed with virtual lbr" in the container,
> and with the python error when run as root on the same machine.
>
> Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Pyt=
hon API")
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/s=
hell/test_intel_pt.sh
> index c0ecece0a8255124..511440b5956a6897 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -384,13 +384,14 @@ test_virtual_lbr()
>         # shellcheck source=3Dlib/setup_python.sh
>         . "${shelldir}"/lib/setup_python.sh
>
> -       if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
> -               echo "SKIP: Python perf module not found"
> +       if ! "$PYTHON" -c 'import perf; perf.session' > /dev/null 2>&1; t=
hen
> +               echo "SKIP: Python perf module with session support not f=
ound"
>                 return 2
>         fi
>
> -       # Check if virtual lbr is working
> -       perf_record_no_bpf -o "${tmpfile}" --aux-sample \
> +       # Check if virtual lbr is working.  This records aux samples, whi=
ch a
> +       # single data page overruns, so give it more room than the other =
tests.
> +       perf_record_no_bpf -m 4,128 -o "${tmpfile}" --aux-sample \
>                 -e '{intel_pt//,cycles}:u' perf test -w brstack || return=
 1
>         perf inject --itrace=3DL -i "${tmpfile}" -o "${perfdatafile}" || =
return 1
>         output=3D$("$PYTHON" "${shelldir}/lib/perf_brstack_max.py" -i "${=
perfdatafile}") || return 1
> --
> 2.56.0
>
