Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD84683;
	Wed, 22 Jan 2025 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505188; cv=none; b=VfS9+981nokJ+p6284dHOu5EjYeVqWRLsDkrfI4yfcCBWs92w19eVUzw90RPpKpnntgVluGGuxE3UCORTdysIx4XNW988Iyov/NuFxB3pLybBtLwT7b6V5uhk1HWzKFOd9CGRQ8jB63YNuRjOPGC3gAcxfzau3KC6FNGQ8Qh9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505188; c=relaxed/simple;
	bh=ggjIsDrsrWGVtT3ihMeuRQIcwyvJColGA7jfN/MwXB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNgEUwmt97/Uq7WsVvu+Kzqgl588IwZKeNV1XImZh1K8ohzvFHLz9OUzJCvRsBRURUaegWKjSRVt5ZnKoRJOsjNGETZPfoaKr9CWSNL9ed9UfbVuOJjitM8OiqtyqiN3+cxEZr9DgYT4QkAgQYX7GUfVSen3P570NaAy6xdSfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYdoftoU; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYdoftoU"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e46ac799015so8307997276.0;
        Tue, 21 Jan 2025 16:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737505186; x=1738109986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p3N4rQfMmarydSTgCQhLRcvSZzyP7GOZZJT0NHciDg=;
        b=WYdoftoUJLG1gV57ukLp92fmb6meO2i0wb7kPU5+udriVtAmR7MgCSXIuqwoRphpQB
         a5sTf8w7t/T6lv3922oaeOUICRkbW4XESgXJuJ3hw0HlplM9uL1o0gHqi/lHvxVjYscw
         pBgMSQPZr+vUdbotMp6X1eoOVE3aendbY/JJZQLzlowHIxEic1mec/UNscuhF8ncnGTw
         bFWhPSh9xJCgglCdGzdGdzsW0rIJ1zIRTLphohzeEju5saVbYv5Lt16KnOywe6vE70kL
         jv4PfPjATNw/uYPnB7WsRZasY6mcwPn4n8VKOW8cB7F7HpNZY5XJ+bDDAqeAK4rM8dBP
         db2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737505186; x=1738109986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p3N4rQfMmarydSTgCQhLRcvSZzyP7GOZZJT0NHciDg=;
        b=rKF9IrzVMf/31KO+OZcEteNwnIJB+/2anjHoT7/QKEWG4Oukbaxh3g+7ghKYqf88ew
         uIce+wXcOTWoPBodFivSWZq3NNCsDK+CseWFZVUJqzB3C0cCawC4zHaBef/FpsVsKRev
         ZQzmR5FX/uwMeJGw03LdObwPPt+Gt5VBHBI+sxdlTnb4+kZLLaLo4mI6YFpe/LdZr468
         rL21fYV+uHspcTk+nDjRCS2KjX4Z7B//y+/mplQGjahy8GqeO/Kq0AeiJY5rEnX91ADx
         Sm3F6m0t6U/dhvvUFCGSnbh5Tqfm0CCqZ67XOB1EfAHO8/OfNSfnTOgGH0ezZk8pclgT
         ogag==
X-Forwarded-Encrypted: i=1; AJvYcCWK5KBYy3N/iWwLqSSPaqnz3o8LMJAbU6qGZeDaK0vqNWEQKuw7jA42owKm10iJ8rPGmvaYw5/uUIk+1f4=@vger.kernel.org, AJvYcCXMCeT+SUYUEE1xbqrcViMH2E06JaWLXyh/M0Cee0hEUXHHi4OvWVLgACrEluR/wxzGv7AWbgFy+dSe2BTixpF7/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5hbsKsP4gOGJQ+Wz0JGAK+1o32+oroKbg5na27LRfms2DPNRY
	fZOHXwNb1W91u9at+j5tapO37m/YKZz8OP6ojxSNJkpZ4AgsdZ1dou+Xqj0mjq/8nZDh4GSwtRJ
	/8FCKoqMfFxJhBpmFMF1gPjg/msY=
X-Gm-Gg: ASbGncu36dfM1mmG8+DuDkcq5iupr7t0itB2GBP1ED4ApzCNY1eTVS0oloKOs1UdBC5
	BZJSMRZr6AR+zXz+9zQWwCK7lGofwR8dE6Um7E4CQ+wWTbNmUZw==
X-Google-Smtp-Source: AGHT+IG2vyY5hOdjXMsx42D+uRiTAmJGB33vyNVqQCRfX0PhgPOiwqHkNCxMbOn/hWIu8RpXGNWMgu/EW+PrMdUG20E=
X-Received: by 2002:a05:690c:62c4:b0:6ef:aae1:ac5d with SMTP id
 00721157ae682-6f6eb90d588mr164114347b3.27.1737505185910; Tue, 21 Jan 2025
 16:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <Z2CGdi5xpJy6C6sv@google.com> <Z2mzzytPOpjF0Hxe@x1> <Z2m8qzyLdm1BEYuF@x1>
 <CAH0uvoga29=0iF69A5uHN+nbB458LeW+WDWHNnoQV4msVm9zDQ@mail.gmail.com>
 <Z4U343yQUDF3H7qs@x1> <Z4vyvNChyXZx33xf@google.com>
In-Reply-To: <Z4vyvNChyXZx33xf@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 21 Jan 2025 16:19:35 -0800
X-Gm-Features: AbW1kvZzOf_JfaKrmnzGyIMKzSdxq8K5Xf73eXH4Vh8jxPMexoYCOTvCEtVmcOo
Message-ID: <CAH0uvoiRTnT-=EeK1z6BajB9RE5F=f2S4e5a5ygo8kebyKyCqw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf trace
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Sat, Jan 18, 2025 at 10:28=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Jan 13, 2025 at 12:57:23PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jan 10, 2025 at 04:52:08PM -0800, Howard Chu wrote:
> > > Hello Arnaldo,
> > >
> > > On Mon, Dec 23, 2024 at 11:40=E2=80=AFAM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Mon, Dec 23, 2024 at 04:02:43PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Mon, Dec 16, 2024 at 11:58:46AM -0800, Namhyung Kim wrote:
> > > > > > On Sun, Dec 15, 2024 at 11:07:09AM -0800, Howard Chu wrote:
> > > > > > > Changes in v4:
> > > > > > >  - Use if -f to check the existence of vmlinux BTF, and exit =
if it
> > > > > > >    doesn't, so trace_test_string will not overwrite $err, and=
 keep
> > > > > > >    running the test.
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > >  - Add vmlinux BTF check, and skip the tests if it doesn't ex=
ist
> > > > > > >
> > > > > > > v1, v2:
> > > > > > >
> > > > > > > The previous version of the perf trace BTF general augmentati=
on tests
> > > > > > > didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
> > > > > > > <acme@kernel.org> for pointing this out), this version uses b=
ash instead
> > > > > > > of POSIX shell to pass Shellcheck.
> > > > > > >
> > > > > > > This patch series also adds documentation for the new option
> > > > > > > --force-btf, which is used in the tests.
> > > > > > >
> > > > > > > Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I2=
74@x1/
> > > > > > >
> > > > > > > Howard Chu (2):
> > > > > > >   perf trace: Add tests for BTF general augmentation
> > > > > > >   perf docs: Add documentation for --force-btf option
> > > > > >
> > > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > >
> > > > > Thanks, applied to perf-tools-next,
> > > >
> > > > It fails when running in parallel mode, sometimes:
> > > >
> > > > 109: perf trace BTF general tests                                  =
  : FAILED!
> > > >
> > > > Then:
> > > >
> > > > root@number:~# perf stat --null -r 10 perf test "BTF general"
> > > > 109: perf trace BTF general tests                                  =
  : Ok
> > > > 109: perf trace BTF general tests                                  =
  : Ok
> > > > 109: perf trace BTF general tests                                  =
  : Ok
> > > > 109: perf trace BTF general tests                                  =
  : Ok
> > > > 109: perf trace BTF general tests                                  =
  : FAILED!
> > > > 109: perf trace BTF general tests                                  =
  : Ok
> > > > 109: perf trace BTF general tests                                  =
  : Ok
> > > > 109: perf trace BTF general tests                                  =
  : FAILED!
> > > > 109: perf trace BTF general tests                                  =
  : Ok
> > > > 109: perf trace BTF general tests                                  =
  : Ok
> > > >
> > > >  Performance counter stats for 'perf test BTF general' (10 runs):
> > > >
> > > >              2.148 +- 0.293 seconds time elapsed  ( +- 13.63% )
> > > >
> > > > root@number:~#
> > > >
> > > >
> > > > So its not just when running in paralell, anyway, its merged, we ca=
n go
> > > > on from what we got there.
> > >
> > > It never fails on my machine, I think the reason is my machine is not
> > > fully-loaded. Can you please run
> > > ```
> > > perf stat --null -r 10 perf test -vv "BTF general"
> > > ```
> > > And provide the output?
> >
> > root@number:~# grep -m1 'model name' /proc/cpuinfo
> > model name    : Intel(R) Core(TM) i7-14700K
> > root@number:~#
> >
> > root@number:~# perf stat --null -r 10 perf test -vv "BTF general"
> > 106: perf trace BTF general tests:
> > --- start ---
> > test child forked, pid 47824
> > Checking if vmlinux BTF exists
> > Testing perf trace's string augmentation
> > String augmentation test failed
> > ---- end(-1) ----
> > 106: perf trace BTF general tests                                    : =
FAILED!
> > 106: perf trace BTF general tests:
> > --- start ---
> > test child forked, pid 47842
> > Checking if vmlinux BTF exists
> > Testing perf trace's string augmentation
> > String augmentation test failed
> > ---- end(-1) ----
> > 106: perf trace BTF general tests                                    : =
FAILED!
> > ...
>
> I also see the failure on not fully-loaded machines (both Intel and
> AMD).
>
>   $ sudo ./perf test -v BTF
>   --- start ---
>   test child forked, pid 525025
>   Checking if vmlinux BTF exists
>   Testing perf trace's string augmentation
>   String augmentation test failed
>   ---- end(-1) ----
>   106: perf trace BTF general tests                                    : =
FAILED!
>
> Thanks,
> Namhyung
>

Just wondering, did you and Arnaldo apply this patch:
https://lore.kernel.org/linux-perf-users/20241213023047.541218-1-howardchu9=
5@gmail.com/

This seems to solve the problem for me...

Thanks,
Howard
