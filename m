Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC7729A5
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726721164; cv=none; b=gHjJ7dLL98/ZVbBml39BOclVRoPCI4u4ogWhy1arLL5DaOlQDMLIemjbULUDS+1IZS8wSGu6PAVjb7TqDO2MbLX6A/qOYS1FxnKaZb4sVbMR4hao5JtYrUiEY3FWWkeKs8jgldt4iv1VYGM07q6xR3ZaXsxXx4I8rLm9JITnY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726721164; c=relaxed/simple;
	bh=TwEXiCTK2Uz40eVQrDkdsVUjwIkQsAUUrPZQ/wf6MFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFQEGYZ+bCZAW4/ztLF/7kPvIrd0+iclYEu2oloJOTN9kDZjYAb4iB7BrsGItJilXBT/snnLYWxAQ2QaT4Osz2lB9gYJuxULjHhDeUW1JGrAHJqx6tJlrz0O95INetdCrY/R4dVQVcncM1P8nVXeEN5eKkOchnahPPYkpjelq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpIpGRIy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpIpGRIy"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2056aa5cefcso287915ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 21:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726721163; x=1727325963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwEXiCTK2Uz40eVQrDkdsVUjwIkQsAUUrPZQ/wf6MFk=;
        b=tpIpGRIyA+VAz6UlkUw/oDMPups2Uj+jz+xC/nSOSTWSqfKTRsO3s3vNIH5bYQ2FjI
         I3//DWtrysf7Ko0ZuYS/WSAa8BmINUnCahjy05B3F5E7+PgZWdZYEbha4pmaX0qCanA0
         xkYIIDPbuIAZr0HpSmIprV+Hy8rD10mYFsAIgi4Tk31CdX+TfWmJcZ9NaaNyNBHU5US7
         f8y2UyjMJTgXp6TeNZnXsjUHdLCxPtkXjSy+hbk9lt6O6u5derAnb4uDtnqQOqvMTVzI
         ZybkG9SjIPi/AMjanm7l0A+i2Kjdp4meKfLv/MTza5JPZqzdBS3BEViiQPe34KWp9uqJ
         oE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726721163; x=1727325963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwEXiCTK2Uz40eVQrDkdsVUjwIkQsAUUrPZQ/wf6MFk=;
        b=RequdDtNsObOfhVxHc3Lx1ut26V9BOV13d4n4FpQ91bstZUE9k0Huo5zLvv2T5vOcQ
         8iVBiybxVU7yX+7wafnImrD8mkTQQhqdNoN12LrkULDoxSLcRNMlkZSonYiPLRVQWVgI
         h9S/JWNLRp4pDOY770R7Ql7jQyia24VuNFA7XKbhjAMEnQSJR1Lgt8CF9b7g0vih+n/z
         4Dx/S8MYh7L2/dx79ON4zJhs6hV6ZUXejaYYXZW3cHNxbceQCEtQfoRGiDZduwiOGS44
         3/kELEha2zlygLAP3UaE/WQ/z5M8JUtGMKfhD08kahq+idgmURQEO3T/3IuI8LbS5y1J
         vwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrcHXJLVCGdax47yNukGcmpbyNMBXFAAOa53QA68H+LbR3dmW8ttcuRe+Px4cOGzBUuTP2pgoLO9Ce4/ZjVD99@vger.kernel.org
X-Gm-Message-State: AOJu0YyaYmVddqFAnMhIa/9yKl+Wqeei+SMuyXQYbaTPBvLeZLXw9SZp
	FnVOKxDH9YJDJ/6FeHxB2JmGEg4aXGAG93W9FX/sr//NynNPsPCuw60yMLFJ6pPUb3VtFhS1Umf
	T+MXCG0S/lTnJZKOVWg4tvVe2RpOEIJW21Wph
X-Google-Smtp-Source: AGHT+IG4ekfuJ3oQqUYYsIQztac82JCGUipLZRm5ycjs+VUpfL68rilPuCMGoK7fBKNpUNNv1tmTe96YnK9xIB9zYtU=
X-Received: by 2002:a17:903:1ca:b0:206:a913:96b9 with SMTP id
 d9443c01a7336-208cd599c9amr1009335ad.10.1726721162266; Wed, 18 Sep 2024
 21:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918225418.166717-1-irogers@google.com> <20240918225418.166717-2-irogers@google.com>
 <Zut-iM3v9rJHehxJ@tassilo>
In-Reply-To: <Zut-iM3v9rJHehxJ@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Thu, 19 Sep 2024 06:45:23 +0200
Message-ID: <CAP-5=fWS-xOPurApZpMA=Zzukt5PQDYjF_7otCPTAL33PYmXAQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf python: Remove python 2 scripting support
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 3:29=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Thu, Sep 19, 2024 at 12:54:17AM +0200, Ian Rogers wrote:
> > Python2 was deprecated 4 years ago, remove support and workarounds.
>
> Nacked-by: Andi Kleen
>
> I don't see any advantages of breaking perfectly fine existing setups
> for no benefits.

The reason is that since moving to linking libraries rather than
building code we now have the ability to call functions like
parse_events - previously parse_events was stubbed out because there
was no way to build lex/yacc code. Calling parse_events is more
sensible than existing logic that does things like open a legacy
cycles event only on 1 PMU type. That is, the existing code doesn't
support hybrid. Practically there is no way to test python2 support
builds and works without having python2. We shouldn't be in the
business of installing python2 in 2024, my organization has removed
all support for over 3 years.

Thanks,
Ian
