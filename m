Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABE4078E1
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983564; cv=pass; b=u83UXmx+Q+PTm1SdetUj+oZs0a2QQYGNgt0wjiUp4Jo7F5Da3jmcALvMixoqvSaDRpS90H0+Rl+gLr3GaXh0HJip4BXp5x8rNvkCfM3xp0kYfmX1FUU+vKV8OdZUlK4V1IjFOlaZZiIHJzK7o+G+2uNl0aTDayksKlvyNJZQXOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983564; c=relaxed/simple;
	bh=u8gVVSgBrEyEZ0ngpczrNEJeXuDf1kkf1UVuVDZXvhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhLSwtEqGRzTi1LMkt8lYbaOFaPXkVpJAfuRo8lCh5jZAxGwTythjmPiCMZhvYKkfhvqt7sqSDP50FjrZN5/cFZ86d2nDoClE7A6j38GsXPxLh51tv9Ral1H7QMfXV4n1ejvIAdlsw3G5Hp2pttQjEqZ7mA7SdBsDY8BW1JNPT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=poPoUCJa; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="poPoUCJa"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672ce86b21aso40726d50.3
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 16:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790983562; cv=none;
        d=google.com; s=arc-20260327;
        b=UgTaz+J/Md9VW899hFDvO/kcM0ik8xhw6wIEv+tfZ/X5cmNSZdju5gJc3uqOgeVzIh
         uUbmu/umfanSAtJysQqB9yYbWzA5ZlJFpoj6aQZvHPTIQg4MD7Onht+ZQziG02clv7Gt
         pJARWsEEV1L7NNyRQNn2GqCdtL7VFq9VPzcLHkG2n/Fx1Ayk8h9ajXBoSw2zco5uW62n
         QRUyud8X8zCASyzagvo1zLcOvPQUMHs1oUGGwTqLD4F5yUiGsuCbQQmfiKRdD63WeaZt
         jkn0Nx8R8OF/RJgj/4fHkfm2gcCtmHRxShyv7SJRJ+W+IQGsaAUQvf/KH5rVNhL4dS3R
         vNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8gVVSgBrEyEZ0ngpczrNEJeXuDf1kkf1UVuVDZXvhY=;
        fh=AkUAc9PDsI9ZlWTuSygdM+NPGmI20lerxQ/cmv82vHs=;
        b=FTY+CNjaOWeDiJOvnvNsIJs6cL3tWHLzPWYPcm4MOlSS2F3bpXCS/3MW3KeAvuiwlW
         JA0goEvJ2v32zjxVVl6Zwgyu0oCYIMODPSHpvQqRTMfo15+Ll+3UMI1HbNL3OF1aVt90
         diPtqKdYOaqvVusKEwfe6eT7Gh1pz4W/R/61m2XYqOWZrvP4P8vS/RAMbxAn/3MYRZvl
         7S/98XeKPMAuzEAQHPjVs9kF63foRc/+X7X8BAGHG2Kc/R14RLYqMUJgP9SXHRKxqDty
         jE2KcZMUtW34WAO4AeuOubWItiuMAt/FjVt0DU/49s1XOiY2k4MDO5XT8Jg8QRjzsL5h
         8vaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1790983562; x=1791588362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u8gVVSgBrEyEZ0ngpczrNEJeXuDf1kkf1UVuVDZXvhY=;
        b=poPoUCJaJTVARtJ9jLfbIFI6Oo+P1THbdWPGmccfi+WPK2khdYHENXGWmyMO2PSsMg
         ogMWPoE8fqSGxU94KhWPDFXbMP2Ae9duaCM6oAhoMrlRMODEECvMKXf6epxhkR59sddT
         sslVGO7JiQSTmRhjbsvsNE1/+G+4+r7xgGzF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790983562; x=1791588362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8gVVSgBrEyEZ0ngpczrNEJeXuDf1kkf1UVuVDZXvhY=;
        b=Km4sENJ0jH3mXAObqFTEedZb5/fC99SFjoBOCWslqmbtnEhucHYLKyLlDttfVCYVzC
         7lbnuhIunU7AkMe4JDUpVPeRmNcmoDeS5XDq1jfn7d1VBykSYL6yOJNXH/xWzTY9BmGU
         L1rqfajZRTHAakqm7Ka10KjyP7axCKAfFZ/KVgIFhD8x5WlF+2SLnM4plFUDBqAKHUj9
         cvaLGj4AvEORuzGLVWBX6vXEvTLa8AudX2nVoqIYjO9cSXD0ZVatRl04T6X0ecY0p68W
         EjUrD7JXgDIwy8D8OASSLiW4hALJSPqAHeq7ELgAzg3iVYAliYPneI9blAcgHGz6CJOL
         4UsA==
X-Forwarded-Encrypted: i=1; AKwUvBxwUixqofhdfFSmpGUQ0wVOVrsZe3wybS7iCfIs7O5kXkZj0ANrF2OcmkSxrppeugGiPNFQ6Jr/ZjKjSjn9I2DE@vger.kernel.org
X-Gm-Message-State: AFq9FYJetxpn72C9XbRpN7DYgWLV2y8mCIkkJcZs/idyyxLxTtqkXACt
	BWzENhKdMzycoUuXHAmRVUEo3S+FSypCf9EmmG5u9J25edkQbSZsTLu6p5pH6dHinvQv8E0MctL
	wsmTLiXl/SXuuqrkf6eccAbLtflrkJYlMGcRKZ5gJhg==
X-Gm-Gg: AYBFou3vXPys90bRHGrnpQ3AXVgNHRBw5JaKsXFjLasxpqMPBMRwranLrie9V/xScUY
	f7cHIdRAoYKhizJ9kjpf43LgZ05RGrOb1cZ70n1rtL8a1p77vPIHocr2kOUG84yi2J32ICU4DVm
	MuiifWoOiI+RzXR2GEkTrBQ+29e/b8HEDeB6CHROsyoUit0p+QFlqkUgNoYXojYEjyeTV7q6Kdt
	6RXaKErd6/hoSyl1ZAlWRqNzNmppf/P9IN2UIe5KXgY3J6mNZUaWAcHZWNNcl0kvuQaJ5nDkeKG
	ByBHmE3t+D74sZzi5jum1cPMYb5TNNOKMxGBsR/RgQNQpLEclMgFBi1BFdN/cknwX0XTVEjbR2Y
	4YC5/D3hu3uu0nTXPFLiZ6w==
X-Received: by 2002:a05:690e:804:20b0:672:99e0:ebf6 with SMTP id
 956f58d0204a3-677ac1af0femr1170670d50.142.1790983561984; Fri, 02 Oct 2026
 16:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
 <20261002-perf-symbol-memory-send-v4-2-0a592bb2539e@uber.com> <CAP-5=fX=BvLMm-JHLqaR6ACmP0buF9TSvRLf_Cs1us-o6aMGRQ@mail.gmail.com>
In-Reply-To: <CAP-5=fX=BvLMm-JHLqaR6ACmP0buF9TSvRLf_Cs1us-o6aMGRQ@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 2 Oct 2026 16:25:45 -0700
X-Gm-Features: AclHuK-ph-iyfrQ2eVW2jG3FptK-AGuI-o72WhxQK4yu3pLAKj6OtRrC1G1nndg
Message-ID: <CA+w=M=REOd1gvi+c6vkd0Ue=q2d_gfC2xeJ_KSVg0H0AaOA+pw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] perf dso: Allow reading DSO data from an explicit file
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 3:13=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Oct 2, 2026 at 11:46=E2=80=AFAM Alireza Haghdoost via B4 Relay
> <devnull+haghdoost.uber.com@kernel.org> wrote:
> >
> > From: Alireza Haghdoost <haghdoost@uber.com>
> >
> > The DSO data cache derives the file to open from the DSO's binary type,
> > which can resolve to the runtime image rather than the file a symbol
> > table was read from. The lazy symbol loader added later in this series
> > reads symbol names at string-table offsets in the file the symbol table
> > came from. With split debuginfo, the data cache would apply those
> > debuginfo offsets to the runtime image.
> >
> > This patch adds dso__data_set_path() so a DSO can be configured to read
> > from one exact file while keeping the data cache's descriptor eviction
> > and reopening. The path is used only when the data cache opens the file=
;
> > dso__get_filename() and its debuginfo callers are unchanged. Such DSOs
> > may be owned privately rather than being part of a dsos collection, so
> > the patch also drops the assertion that every opened data DSO is in one=
.
>
> I think some context is missing here. Why do I want a DSO that isn't
> part of a machine's DSOs? I can see a use for testing, do you want
> this feature for more than testing?
>

Yes, the production consumer is 4/5 in
tools/perf/util/symbol-elf.c:2143-2146, where
dso__build_ondemand_index() creates the private data DSO and sets the exact
symbol-source path.

The lazy loader needs this data-cache handle because the symbol table may
come from separate debuginfo rather than the runtime image. Namhyung asked
during the v2 review that this known split-debuginfo problem be separated
from the lazy loader as an independent fix.

Thanks,
Alireza
