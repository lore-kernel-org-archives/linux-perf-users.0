Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD2363C60
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908531; cv=pass; b=q9KwMRDsCQYO8Ce+j++EaW9ICWyXFZfCcZBZpo0w8A0C62upS4P8D9JvJmJsGIfixTwjjntOxLqnRjw6oYIW+H6XF+8fHhH2i7LJp/UDeqVNHgwmqXQQgs9CBgKDCxJzvMJn3MlXJygOIiHAs8ZKIfOCyziXB/3vHXsbNMXniBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908531; c=relaxed/simple;
	bh=01DMyjb/HZSvI6O8znLL6RPAI6YtqeAqhwj7l50SI/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwSaNeQpLTKSyJV0nqsAjxUvoVY2Z9PKrGmWgl093WFzrEDvDe9qszsnv48ByU+851jH4gZOXnHxbGycMrsoC0m31lzdrHssvIAevfeTkPhrstlgT6rstPci9CIJR8GFq/ovrguLzIyvw/VZOaYRfieAmsepmBlSeRwz7X9sNbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDVUx6F4; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDVUx6F4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so61065ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 01:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773908529; cv=none;
        d=google.com; s=arc-20240605;
        b=LjzCcS+gna12vUmyfG1vSTJK53ijW29hqwGkqnkQMDC/JNyqUKu6EhDvID+u6NHycX
         nK9So000MMywmfHbJ1Wmc5kKOWKPz6A2imcXVADvKKfjGIS08ZMFzzhzGKrGfOkGOWts
         g3ZJL06KvcYwSlDyv26E+t3wRsdwJXOjglPxnbb5qHwtXv98D8SblGxfOHIoDeH8tThH
         +kIpJ8UORaAqIY6M7zLVll7k2OgOocdnrjaDfXmhdp9erxn5ygqVUkpHg73MxjsVkUsA
         dAHMvK3QjqVD7d/hvbVpL7F0OEXt65RnN1qXkFX6/9GjQzgCzDaTvPnhq6wHISP2J35h
         BqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IHfTqB5YPEraYU2kXL8nscbmS2lKLIijP1hKdy0xaBM=;
        fh=JpazO/oEt1nsqcI2v1EyG9lOJRJ7fems3D0Qeroc1xM=;
        b=anQaOAtWgAELQ/1OnlGe9WJ7YcIJbxSlGwg0QCJxRCyAFzl5lvqDZ9yoLnN9Vv3z1s
         9sgLRmT3KN41uozDjAN13PAHTZfwHETimHlG8CaWghc6xqie4VkNLb9Ht7JoS1q51ylJ
         ILlJfJVmMQVo3yE93pqCie6muqmMyLBXVv0Msd1rqUNdoqNAt/d/7wlp+1xMv6nzeA8a
         f43Wusrw8aJnLbElRT5DDM+I9MqoFuuNQBsbSXva2ObcYXo4ZVA1ToD7J8GZcBKSmyVC
         qI5sbA27y/lG21EraewkSxhuszjCnKOkeC0QYJBcnAa6/oIH+tQUNml+X4iKTXzxYV7t
         uE5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773908529; x=1774513329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHfTqB5YPEraYU2kXL8nscbmS2lKLIijP1hKdy0xaBM=;
        b=LDVUx6F4cv1JCa5g41Yai2tWjycFahZm0tz7+oiLGIFhJZbbsOOsm9v9sDkJmKdKFU
         HBEKF45AFN7rxcn4EcbUslLb141GuYBbQDOVbTnR0HgQmzum343aKhAY4aP8k5G0KS9M
         EB/UCHTapElmL86+/XDIJJ/ZINFF/kWpsTK1q/w8AkgAR1k5an6I1V4GXB2OEuBuLb1u
         fD+W5lk5ZyVgE8nOTPd0H4pAflTGv5xtgQEjsvjBmcF8ipBzec8s/aynqG4T091og1+J
         KcXUl9prYV82PiUoadi+MlNzB9na+XktFsjD4RdmKP6YB2WyPIvov4RZZw4bCEi7Imah
         HjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773908529; x=1774513329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IHfTqB5YPEraYU2kXL8nscbmS2lKLIijP1hKdy0xaBM=;
        b=cdMxUtnGjKFTiE8tLtDUn8EeubL9nVhrxN2K3N6fdZNNMtlwVUy4mDRq+Tgd33rFOc
         Xi6+AhKp7nNJt0g/JxMVoolvLYywfQiggxFzORGUr3VvrGfVSxg0tuJbVnqNCa5YHjIg
         Uks/Y8ukdCYDe6fOHIxxQL0DHapyqPKIqVGQkFnMMtnZOWUXEG4MlLlLhu1LJrpVlRZ4
         KYi6PA6tHPFTYj8iY72J0tLJbK8/GECA93hdno0SKcmAHzaWTnoAdmiheG2MRUuoC7qo
         CQwkIH5oYouYN1J97kXlF2slES6jVhpsWoWsboSDXTSVW2Kvr9bde9Hg2ecdm9QwIEhs
         hjew==
X-Forwarded-Encrypted: i=1; AJvYcCU5aohw9aaNAe61iHhDg7QPF/g36VSezX1yg2iMRkwriKOwI97XdMvNf5qBfin6Hn/nkzCSJl1vftlOLe0NPPpq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzje7IzveLKM75KPxAXz8WhSwaNjKxknV+Wh/FhXp3F+K9ZKTJ8
	O1yXMQVpKE3W30pkfQWl30kH6OMqySK6N4fmmcia2dGUY/e78VLRwWyQpda966N2BHfzA8oU6NL
	rfet77QdeOWlRhbX9HX5jKyaPxEZWfObty20sYv5y
X-Gm-Gg: ATEYQzzO2TtMOcFntvvTJz0HEedncx1MAc8j/TkDtNk4Jrgyd+Oq1P5S2T4Jw6/npb4
	irfNgM4RZl4HYUT6//myceCRgCl8DMQErEBd+9KPIvFdRVziABf2k5QAwvC+wvkkqKL4gxuk1Ph
	pc2y/RMYza3a/H3NPbVXa4fzp0Ml9VnB/RPaRTx+2F9Rz32NqJU0mBGHDQQv2clUCA+Tw0X3812
	OEsOxzyJMzK/yR3yZP1HWB2JNnNFtGgqc5pTde3grQkVkWFNRgSfsSzg08HpCDWXIhQTGHhmwur
	7qtC28lh
X-Received: by 2002:a17:902:ccc4:b0:2a7:d266:d84a with SMTP id
 d9443c01a7336-2b079fbb39emr1497765ad.17.1773908528384; Thu, 19 Mar 2026
 01:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <813bc5fd-0c35-46af-aea2-90798154daaa@windriver.com>
In-Reply-To: <813bc5fd-0c35-46af-aea2-90798154daaa@windriver.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 19 Mar 2026 01:21:57 -0700
X-Gm-Features: AaiRm52YAXaNrkUnKO5zFLhl-iDdZJWeEPshCImbwceVdhaH6rxOGvGt1lbz9ew
Message-ID: <CAP-5=fW_O_sm9JzfCf=qDXyaffoLLRH3mob1zckESUHsG2rp-g@mail.gmail.com>
Subject: Re: [REGRESSION] perf build failed after 5cf6e76e4f4f ("libperf:
 Don't remove -g when EXTRA_CFLAGS are used") on riscv64 with gcc 13
To: Haixiao Yan <haixiao.yan.cn@windriver.com>, Chingbin Li <liqb365@163.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 6:57=E2=80=AFPM Haixiao Yan
<haixiao.yan.cn@windriver.com> wrote:
>
> Hi,
>
> Commit[5cf6e76e4f4f](https://git.kernel.org/pub/scm/linux/kernel/git/stab=
le/linux.git/commit/tools/lib/perf/Makefile?h=3Dlinux-6.6.y&id=3D5cf6e76e4f=
4fee54c0056758b639cf4919cffba9)
> changed the libperf Makefile to preserve external CFLAGS instead of overr=
iding them. As a result, the -O6 optimization flags from perf's
> build system are now inherited by libperf during compilation. This trigge=
rs a false positive -Walloc-size-larger-than=3D warning in GCC 13 on
> riscv64, causing the build to fail with -Werror.
>
> | cpumap.c: In function 'perf_cpu_map__merge':
> | cpumap.c:422:20: error: argument 1 range [18446744065119617024, 1844674=
4073709551612] exceeds maximum objec
> t size 9223372036854775807 [-Werror=3Dalloc-size-larger-than=3D]
> |   422 |         tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
> |       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | In file included from cpumap.c:3:
> | /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/work/qemuriscv=
64-poky-linux/perf/1.0/recipe-sysroo
> t/usr/include/stdlib.h:672:14: note: in a call to allocation function 'ma=
lloc' declared here
> |   672 | extern void *malloc (size_t __size) __THROW __attribute_malloc_=
_
> |       |              ^~~~~~
> | rm -f /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/work/qem=
uriscv64-poky-linux/perf/1.0/perf-1.
> 0/libapi/libapi.a && riscv64-poky-linux-gcc-ar rcs /buildarea5/hyan-cn/pr=
oject_yocto/poky/build-riscv64/tmp/w
> ork/qemuriscv64-poky-linux/perf/1.0/perf-1.0/libapi/libapi.a /buildarea5/=
hyan-cn/project_yocto/poky/build-ris
> cv64/tmp/work/qemuriscv64-poky-linux/perf/1.0/perf-1.0/libapi/libapi-in.o
> | cc1: all warnings being treated as errors

Hi Haixiao,

this was raised before by Chingbin in:
https://lore.kernel.org/lkml/20260212025127.841090-1-liqb365@163.com/
I was concerned about the introduction of volatile to avoid this
warning. I've mailed out what is hopefully a fix without volatile in
it:
https://lore.kernel.org/lkml/20260319081843.1650640-1-irogers@google.com/
If you could take a look.

Thanks,
Ian

> Steps to reproduce:
>
> git clone -b scarthgap https://git.yoctoproject.org/poky
> cd poky
> sed -i 's/af240d7d57ebf66e87bc2dff34855e630a97ead1/5cf6e76e4f4fee54c00567=
58b639cf4919cffba9/' meta/recipes-kernel/linux/linux-yocto_6.6.bb
>
> source oe-init-build-env build-riscv64
>
> cat >> conf/local.conf << 'EOF'
> MACHINE =3D "qemuriscv64"
> 'KERNEL_VERSION_SANITY_SKIP =3D "1"'
> EOF
>
> bitbake perf
>
> I have confirmed that:
> Known to fail: gcc 13.3.0, 13.4.0
> Known to work: gcc 11.5.0, 12.5.0, 14.3.0, 15.2.0
>
> Not sure whether this is a gcc bug.
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D124549 filed to gcc.
>
> Thanks,
> Haixiao
>
>
