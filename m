Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE771F4190
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Oct 2025 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224445; cv=none; b=pIXeKbQu4kFXljN55Hh1Yuz6pY066lqS3nheueHtMBSeu3iP0KJZngS8wAKSoMipcffPVzvd8Dktkht4UVtKMUj3XUS+ZM9siUZGR4l84iNJig5gZMGw5p0NeWf97uu5BQT83f5nF28KNZU/565BfQlm1vbKjGcHlILf7d3V0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224445; c=relaxed/simple;
	bh=l4Vg3qtmAppls1o5pOQGWkdP2hMZRaM/dEaNNdUEsNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHHCc/BpQCPpRLMrdqwalpv53tGZ1oMoD0O6mJpkfSXjcm6LgkXEXqZTCUPhRHbNyKjysulmwvut73axVEs73c+/Sfw9Uifbj9EE7btwKz3z9GLTHqfRXpTMuyMup6OD4uL0F6bMM0dhnL3yZxOIdx1IYhtgm7t/kaEQ8TUVX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4EF2+p5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4EF2+p5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761224442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4Vg3qtmAppls1o5pOQGWkdP2hMZRaM/dEaNNdUEsNU=;
	b=g4EF2+p5CsoUdsIEoobrV7B+xO4nHw0ndP/HpsykVVg6qCtHX1Z/Ts2nZc5x47EpUkfyKx
	+yQpoUfsUsGrWFR+Vt+U4Gpakul+SM018CfbEhJQIDrb6585ryO4hwkD5xz07ra+/P0BAv
	hrNrO35bdzeY86fzP526Z5OmzJw4Y8Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-KUSnYHgfPZaDY6wiEG1vsw-1; Thu, 23 Oct 2025 09:00:41 -0400
X-MC-Unique: KUSnYHgfPZaDY6wiEG1vsw-1
X-Mimecast-MFC-AGG-ID: KUSnYHgfPZaDY6wiEG1vsw_1761224440
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-378deda303eso2095211fa.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Oct 2025 06:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761224439; x=1761829239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4Vg3qtmAppls1o5pOQGWkdP2hMZRaM/dEaNNdUEsNU=;
        b=HTDXQHdDOvJxHmo3cKLAvfxY00MEYQpoA1eWkOF5mSMVZQGIqEAnryVGwfePtc5Ha4
         2TRyqJRSW9dIV6g//FBRO7rxjAeKSRBnXA/KBM53VGumnOP2kz+mm66Dm0R9sPIvZtEI
         //vkxLxch7FJ6vxUkzSnnAyXLTUVRCUQIW2NZSdrtudIicBXndBiLSy9pkFuMCCc1VBS
         IcGTe/D84B/1nCyrS/iIyUKeJDUNgVbjtjBbXlgO1xWL+e2DmXIvePgtnOdHS/MFbQA0
         U0UsF/CMppOXk6HBe7KHFI6R1cTQkffjiHDmaqJ/LkaxA9CLpT8ezGJ4rG1M56gwvh0f
         iiLg==
X-Forwarded-Encrypted: i=1; AJvYcCWKkUYLyta4QRi0uMC2EzP+A8ktuukHnl9q2M437RIvPyuX5Msuaiwb1ic234gRsim5nGnl3+EIx2BUqxMuGwhk@vger.kernel.org
X-Gm-Message-State: AOJu0YwztpMUb+hz9vUoFuRBh+3Xu301rUmpF4f0y8AyVfYn415+Jg0+
	+j1/qjTN6I0i7nNcrXu3X9y6sRdGMPI6zYb3DmtlYF2WdKFn16mnpH1xQsmqRz16txYWB3OLL/W
	DCtd+Q5/T3XSDOEndyFEnOKSfZ552bV4TnHXc4rbn5ogQGAVCyGWCNPaAdt2396DSZcvkYUH4he
	IF7d8Fek+GQS1twUh5R40aR5TRiN/5MfmKfvE7W5v4HA01Aw==
X-Gm-Gg: ASbGnct+ksFdh1oYKrdMzXN60z1E5kmF+Rc6KmPZTk9Hsv/H4D5ki+PcjLSHW6Gmk6T
	j01rO5fxL3ApTMBABLxYQHoOb7L+/qZGKB+L1btEScgyMTNK5gfeBm/6geEsapkXRcWcJULT4lx
	hJdncekUUjBPB0MB8e34ZhsLRVdGQ8qEtwin64gB2oregUdumOThiRiQ==
X-Received: by 2002:a05:651c:158d:b0:337:e710:a61a with SMTP id 38308e7fff4ca-378d6f4c337mr6763181fa.42.1761224439321;
        Thu, 23 Oct 2025 06:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn76r308X3HSy0sU3SYtZmdtwYQ6TOoutKPqZDCO6ijGuqPjxvwFjYAErnSLngmo7eO2P7HjlWQxFfn6Xv5Wg=
X-Received: by 2002:a05:651c:158d:b0:337:e710:a61a with SMTP id
 38308e7fff4ca-378d6f4c337mr6762341fa.42.1761224437568; Thu, 23 Oct 2025
 06:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com> <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com> <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
 <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org> <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
 <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org> <aO0ci1wX-J3au0-p@x1>
 <9e4d4f05-0c34-46b0-aad9-1431bf8cf9f4@linaro.org> <CA+G8DhJnRB=d+pv0k=uzM18EmhFiQ+AiVu3rb8w=anNgJ=dr2g@mail.gmail.com>
 <abc1cb61-8169-4a26-9daf-264a6d94cc84@linaro.org> <CA+G8DhKDeg61ZM+Pzurnbvvs0L=mdxYhZZTMqfri1wf3AnFaeQ@mail.gmail.com>
 <d207997c-bd73-4dd0-ba0f-93b994b14196@linaro.org> <CA+G8DhKUsbL1q_Av0MzKmJ2XdSpOJiAamrcqYjRekjMbcGtwDg@mail.gmail.com>
 <dcd20146-bb88-442a-9bd6-e35fe816dcd1@linaro.org>
In-Reply-To: <dcd20146-bb88-442a-9bd6-e35fe816dcd1@linaro.org>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 23 Oct 2025 14:00:26 +0100
X-Gm-Features: AS18NWB0bAx3S6Ruugx7W3skYKuRJfUXlkEJQaJXgY5XD_MeygpPxbt6lBHG4r4
Message-ID: <CA+G8DhKQSG=xhst+K-aon=BbVz6wKh2nQ0nOigd0M3pL6N1R4g@mail.gmail.com>
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Namhyung Kim <namhyung@kernel.org>, mpetlan@redhat.com, irogers@google.com, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah you're right. I'll send a patch to remove the tolerance setting
then. It still fails intermittently but that's a different issue.

On Thu, Oct 16, 2025 at 6:50=E2=80=AFPM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 16/10/2025 4:50 pm, Anubhav Shelat wrote:
> > Yes. I had built perf manually from linux/tools/perf v6.17 so the
> > patch was definitely included.
>
> But the patch is for the kernel, not for Perf. So building Perf isn't
> enough, you need to run the test on a 6.16+ kernel too.
>
> >
> > On Thu, Oct 16, 2025 at 4:03=E2=80=AFPM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >>
> >>
> >> On 16/10/2025 3:59 pm, Anubhav Shelat wrote:
> >>> On Thu, Oct 16, 2025 at 3:46=E2=80=AFPM James Clark <james.clark@lina=
ro.org> wrote:
> >>>>
> >>>> But the throttling fix was in 6.16, so I wouldn't expect it to work =
in 6.12.
> >>>
> >>> This is using perf built from the upstream source so the patch is inc=
luded.
> >>>
> >>
> >> The throttling fix that was linked previously in the thread [1] was in
> >> the kernel though. Unless you are talking about a different patch than
> >> that one? And that patch is in Perf?
> >>
> >> [1]:
> >> https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.=
intel.com/
> >>
> >
>

