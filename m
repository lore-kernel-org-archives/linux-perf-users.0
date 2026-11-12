Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504473;
	b=wGa1lM7wUIwWlcduuQmtfjH3og0xOEQYcfUYc+ZtNfoAJbfU4i/19+R7+z1McabIf7Gi
	 x5ySdeD77VnkRU9Ju+lYMewRuwaONAExnQFqcVRNgoKC7tVdDBsFzaIehoG7Udz/zIs9F
	 vafiapdFPiYfHcRNmZ5gq6CRmaff2FCJCSiJd+mynPqj2CEFp6Jk64GHG9MWccnxP5pJG
	 gNe6OCMJ23MeGmu69WmvJxavA6NEkaVflIj6Bkjj14Aoeaky+InL4stbdCOxpr2VDqhf4
	 mf7EcYhr54w8SHgOoRcabz1kHZ+K6azt08uRPmHnsx/u5ns6sH6PuetH5UH6pEQQl8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tnEBsHT4IjNIGwKYMp6J71ouLD/igopL/CMnmWxkUMg=;
	b=ARmBLdDwlhgi3DSx2lWll7WR0E4yv4KlN2S8IpFxDBE3GlPS9+L7dqv58B7480E/1VvE
	 mw0ug5SZZcrKVOx+71MS5Za9DlKgiYkj9PsJa3Um0jTy239YnQNrDweyxN7QVGGZQpPxJ
	 /mBaIsmfzrhmkMpPHxHHmbOeK5kAaCaWv/tbRIYAs5qI56h4eyBvygjUMK6MzOxJvAxDD
	 0tYO3jZqGvgb3tkCWoo3txTlUyquA/jY1JaxUusmBYnjKpwfIH62hBPL2jIC5AgPw+dXc
	 Y1tIiv55wWhFEQJ0Kxg62vV9zPRGvRMikKzxg4uzs+z136g1sX4WpRRNwbzDzSmLkLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FqAASTUF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F7606A323
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 17:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 832F7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FqAASTUF
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-54492d8a988so324381cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 09:27:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794504472; cv=none;
        d=google.com; s=arc-20260327;
        b=sB6QyepFHxWh2QbM5PSZKgq3b8bZd1485XdFl+JOlgL5w3oA8IOOb/3LH+NhF3vzGM
         LfU0xFqhlS8bpz973zYUqGgxZ2J3jyixsiurfMEeK0ek0TtGaF3/Wur10isD2zEAnWxk
         YfYctJz0gwNNiCnjm+PvRHWFM0JrXK4WCcIRS/YYj2hvzh9FCtBUqjI3L/VyhsGONhNX
         TVva3IlyRSkSrd1KBsDImTwl6NXBE3WXLCOrxteHpfQmklTK7Wsm3DwvW/2PC9BH0Nif
         cqshB4t9pov/snTACW/Z17YlSfxEMyt8zvGmwaj8J/l5jWMp3JIFO1SwWXLUko+oeB/a
         /DoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tnEBsHT4IjNIGwKYMp6J71ouLD/igopL/CMnmWxkUMg=;
        fh=TxtZZUZNo2FNYjT9K/vttVtNpkR5nE55JCHZMzFZLDs=;
        b=Xrsz8pcD954YVVV5zRCxLcG6vVKpAvou0Azw9Bz0bzwvkFGuQTJEIpJzp2ATxpMlWv
         hR6jDVkVZzk0S7GCuELQ/nO86MrLNRiEg6+qlPu7qMXieoSOaYnSkXOfWAIKunub4Dcq
         RzZurrjPDBiweAlWIjhMc8dubJ1UJQybpeE/TcLbGx4YevnMiGyqGIP0MZumE8aN+m5u
         gVmHpMLAIad12YxQdsVO+f8UfTZW8OOnNEcPT1DNsnduMLZHErPt1LnZc40hIlajHdzZ
         +j59x0FVRwqj9mh2URTpEabBlx+f/nHGC1X/69iG+eycm0vKF1rO61hQ9dVMNzPUP9LL
         yoLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794504472; x=1795109272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tnEBsHT4IjNIGwKYMp6J71ouLD/igopL/CMnmWxkUMg=;
        b=FqAASTUFGvknZLR6tuZ/VK4egBfwFeb/AEzFa6yq7NhRIKmaSaP45Z3Kj5i1z4SooR
         Sr1H9+GlvCMpk/E4V7VdaPm3GWD2/9WnaXWpx2qFt/rrjThVkpI2zDx8dA+OTj+3Bd9p
         qX7x8uYfvZ6pyoOs7+ereJnbFBaiOyZuA4w01rZ/aC+FxLPxH+oW305x2FrT3xhr99Bf
         uOvXmh8EH2l72ncv4p6NHeGQlAu/D9M55DDiCdlHopRPPiqOK3VGoI+qdgMty8fTJcDN
         InCC9+ANEqQChkQT5MNiyQzRJqVPSc637bJTfWeH5cF6NmJAaw3f+pjzlziSEfXQiOPJ
         l62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504472; x=1795109272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tnEBsHT4IjNIGwKYMp6J71ouLD/igopL/CMnmWxkUMg=;
        b=Uj/7/YhhrGm+F9tS8LWZznr+EFKq5FuhyhcpPuMIGaZKR8Xi0yurgiCSyeWPK/sovh
         XGgIfHEPjN0ym3KATe3qvWjmtdu27w5MmoxhSVw5rbk2A+RAYuaAVA9RPUbjBanwdBZ+
         /p9CCPRlaE4UKh21dut98HOJ7lhXdUYwsyFzxZhcXwQFrCn0lcofFsIm46L9qqhpVZ2j
         mQSgb2iwywnTeALNUaiHbNClET0nWysvccSN82AsahB5ifTXaFAflmU+jHafRXMiVd2d
         F3mG93H2BFyrAe6zY4lCU7k+C+KiqaXswlGjD/x/rHBUn8iVIE05luZHmNx2Vuk3rTDw
         rHiw==
X-Forwarded-Encrypted: i=1; AL+hErGpbd7mVp/LPXkBJBaMI8zmgxn257ivJVvYNBcZXKjZggzEXrBKazxW0dCgAkT645p30YMH/hUNcm32F9JOeDPI@vger.kernel.org
X-Gm-Message-State: APuU4Z8cdzjvYDqGLdZpDCCJeIowLN34AgmDy6/1+4SP9OM5FVEnHWyC
	QRJWlPV3BN/LPjrAJMNNXg+oVZNeF1G4XhT2BNv5NAkma8EId/KGNGfwr2jfVDUA6Td9dTEy5x4
	Ej8KklarO4/fbZMupUitB7aZWWquaqCJGou4z8LTd
X-Gm-Gg: AYBFou2jGy1vszVj54kp6koKTwcVYwBCVetLt8G4ZodonGIx5cfiJlC3yWRdnZA4+Lb
	Tza1uJYC9obndwU6DXfmZj2NpInhuzK21+9zVTmORNfJSjhK4SIYr+yj0GrvUBWlFYHWwNuvYiY
	JdXVR+A39VU5pRKFB/SGJnpYJDRBpdukeohT+LYErAuS3UE+wARLoeOTgZPq6nKYSE+zFw7kTas
	Zhm2YOVgZfD/+5rfL+2wOnXdIF6vlJ0HZxMoNM6MRHQGBcmoXo2CADEmYiRokKDzJu3G+uAe8Za
	hU7HW11PHhxcOfPzA+raoLvsQ4GwwdKbAfeITP0rAu+FTq0jQvPEtL70Pn7+Ksx24umdtP4EQu+
	cGYSu37QE0bSueTaHr/AOvdrwAVtGCAazNPlYfJQB5tc7sT1t1msTMmgVv1hypGkA/g==
X-Received: by 2002:a05:622a:a15:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-55990ed99a3mr21782641cf.14.1794504468321; Thu, 12 Nov 2026
 09:27:48 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAcuPuJUt=Qf6uuTVv63jiY_iCjsvjso1T=WYSFQB=i6Wzb2Vw@mail.gmail.com>
In-Reply-To: <CAAcuPuJUt=Qf6uuTVv63jiY_iCjsvjso1T=WYSFQB=i6Wzb2Vw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Nov 2026 09:27:34 -0800
X-Gm-Features: AclHuK9gXWTIM83w-gVV_norccqytq1EeYN5COdzIUNzghS9AnogfI2G1nfY5Ms
Message-ID: <CAP-5=fWYxRTZmFQZZECLapQCUug-bs3cwTmwYA5SxBy0=0bKdQ@mail.gmail.com>
Subject: Re: [PATCH] tools api io: Return high-bit bytes as unsigned characters
To: Wojciech Szpucha <szpuszi@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 9:06=E2=80=AFAM Wojciech Szpucha <szpuszi@gmail.com=
> wrote:
>
> From: Wojciech Szpucha <szpuszi@gmail.com>
>
> On signed-char builds, io__get_char() returns negative values for bytes
> 0x80-0xff. This makes filename__read_str() silently truncate non-ASCII
> input in standalone libapi builds.
>
> Cast the byte to unsigned char before returning it as int. Add regression
> tests compiled with -fsigned-char, since perf defaults to -funsigned-char
> and already avoids the issue.
>
> Fixes: e95770af4c4a ("tools api: Add a lightweight buffered reading api")
> Signed-off-by: Wojciech Szpucha <szpuszi@gmail.com>

Can you provide more context of where this is a problem? The code
builds with -funsigned-char :
https://lore.kernel.org/linux-perf-users/20260306191908.2065682-1-irogers@g=
oogle.com/
and so we may be failing to pass CFLAGS through properly for the libapi bui=
ld.

Thanks,
Ian

> ---
> Tested on Ubuntu 24.04 x86_64, GCC 13.3.0: standalone libapi reads 0/4
> bytes before the fix and 4/4 afterwards. The API IO regression fails
> before and passes after. libapi and perf build successfully; checkpatch
> passes. Full perf suite and kernel builds were not run.
>
> https://github.com/szpuszi/linux-perf-io-test/actions/runs/43257707229
>
>  tools/lib/api/io.h        |  2 +-
>  tools/perf/tests/Build    |  1 +
>  tools/perf/tests/api-io.c | 33 ++++++++++++++++++++++++++++++++-
>  3 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index 1731996b..25e2008d 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -91,7 +91,7 @@ static inline int io__get_char(struct io *io)
>                 if (ret)
>                         return ret;
>         }
> -       return *io->data++;
> +       return (unsigned char)*io->data++;
>  }
>
>  /* Read a hexadecimal value with no 0x prefix into the out argument hex.=
 If the
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 58858f3d..c3ba1fca 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -79,6 +79,7 @@ perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
>  endif
>
>  CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
> +CFLAGS_api-io.o +=3D -fsigned-char
>
>  perf-test-y +=3D workloads/
>
> diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
> index 0ba3d5cc..f283712e 100644
> --- a/tools/perf/tests/api-io.c
> +++ b/tools/perf/tests/api-io.c
> @@ -98,7 +98,7 @@ static int do_test_get_char(const char *test_string,
> size_t buf_size)
>         for (i =3D 0; i < strlen(test_string); i++) {
>                 ch =3D io__get_char(&io);
>
> -               EXPECT_EQUAL(ch, test_string[i]);
> +               EXPECT_EQUAL(ch, (unsigned char)test_string[i]);
>                 EXPECT_EQUAL(io.eof, false);
>         }
>         ch =3D io__get_char(&io);
> @@ -118,6 +118,7 @@ static int test_get_char(void)
>                 "12345678abcdef90",
>                 "a\nb\nc\nd\n",
>                 "\a\b\t\v\f\r",
> +               "\x7f\x80\xfe\xff",
>         };
>         for (i =3D 0; i <=3D 10; i++) {
>                 for (j =3D 0; j < ARRAY_SIZE(test_strings); j++) {
> @@ -290,6 +291,34 @@ static int test_get_dec(void)
>         return ret;
>  }
>
> +static int test_get_line_non_ascii(void)
> +{
> +       static const char test_string[] =3D "a\xc3\xa9\xff\nnext\n";
> +       char path[PATH_MAX];
> +       struct io io;
> +       char *line =3D NULL;
> +       size_t line_len =3D 0;
> +       int len, ret =3D 0;
> +
> +       if (setup_test(path, test_string, 2, &io))
> +               return -1;
> +
> +       len =3D io__getline(&io, &line, &line_len);
> +       EXPECT_EQUAL(len, 5);
> +       EXPECT_EQUAL((int)line_len, 5);
> +       EXPECT_EQUAL((int)strlen(line), 5);
> +       if (line_len =3D=3D 5)
> +               EXPECT_EQUAL(memcmp(line, test_string, 5), 0);
> +       len =3D io__getline(&io, &line, &line_len);
> +       EXPECT_EQUAL(len, 5);
> +       EXPECT_EQUAL((int)line_len, 5);
> +       EXPECT_EQUAL(strcmp(line, "next\n"), 0);
> +
> +       free(line);
> +       cleanup_test(path, &io);
> +       return ret;
> +}
> +
>  static int test_get_line(void)
>  {
>         char path[PATH_MAX];
> @@ -337,6 +366,8 @@ static int test__api_io(struct test_suite *test
> __maybe_unused,
>                 ret =3D TEST_FAIL;
>         if (test_get_line())
>                 ret =3D TEST_FAIL;
> +       if (test_get_line_non_ascii())
> +               ret =3D TEST_FAIL;
>         return ret;
>  }
>
>
> base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
