Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5E1AC44D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629853; cv=none; b=QSYv1fxdZOFsfkEElXM/oTjpi4K8ZYdsDD1/XtHu8xxmHHi8cHCdlJRvOHahpEjSe7Ftv4h7Uwu1IUB2X9dzvsknwhZ39Jj6VUhIAseHWGKkQGpyPcPu/lntCVPkv2eLM0s4SPp5u8RBOkh8gtOpxCtU1fXx8QuhQIcrQeoOQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629853; c=relaxed/simple;
	bh=qQ5qfrDWr/Il6ioq+DT24NZoFql8vzGHfVym5xPaU0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDRYXryja3o9WJOAsvG6ye77+K22w2yDsDq7Dfmz5sbj0LOdM/s0Z2tBvgM0NhZWLqafbNebG11kxecbVCke+XjJfzE3X4vnIFTU3L87l5ekh+kZvu5ZNJiQnwC7w7IDJTxkYJNWPuj4VQmbnm67WV8djjXeiuhxC5dkB3vsHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoYx04Nb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoYx04Nb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760629850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQ5qfrDWr/Il6ioq+DT24NZoFql8vzGHfVym5xPaU0k=;
	b=DoYx04NbqMeSHj+xV2DI5UqbEDpuHSUSrlZQShLWajubDziv5RPyWwXlYL5H6j7EpNs2ot
	rZBqUmSeHtvNC3RolFWLczquMetkaLRh/6BboZwsATLupvoSIqdWOvtn81z7gZC2LZWQyv
	PGXM3SaGV9HYFCMPYIFuTr4ikpawa2E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-NBE7Uv7yO42V0JpT3HHswg-1; Thu, 16 Oct 2025 11:50:48 -0400
X-MC-Unique: NBE7Uv7yO42V0JpT3HHswg-1
X-Mimecast-MFC-AGG-ID: NBE7Uv7yO42V0JpT3HHswg_1760629847
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-36c983e4c21so6874791fa.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 08:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629846; x=1761234646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ5qfrDWr/Il6ioq+DT24NZoFql8vzGHfVym5xPaU0k=;
        b=R0P1VzHsedXRqrx0qpHwk1HHWXr9NVajQIvDugtczvDEaB2JHSqueBSRy6insu7hyd
         w8SUI4UK06d6Nr3o+D1go64fXYPd0QtTR9a8foHV72QC59mBs4JkqEeuO8YvHPmij1Bu
         6ZLb0v1swC52OJlGIa1MdIgqJbpghcNhC0G8o2urHUzWoXdYxSmws7SqLy0khmomNPGa
         /FwxubiDOrEOvfyOwS8/ighH272/pbSYf+1miNqKCLuodsytYvdAVGNHuBxsUVpfe/9e
         0yyqCswzZnDuqwzPxSvRbCdheEkNWNcN5ovK+8EcCrNfTfR85/6GrrUWE8FlkvMdLCbD
         t+sg==
X-Forwarded-Encrypted: i=1; AJvYcCUloIq5ftjV4cTyfYGES+0S5EN8a2jsqMnqd91MUy7ZA4juS74V9/SlfvJawwtKv1NFYGMhFtj0EWE/GtVoveli@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRlW9GDaoDNpU/xrE+SF72htBoIvMTkyInJycWkppgZilXYSQ
	t9cn/UYK+GYLoQJGr3D7eLyB7y38tcrVI8tgLju2J7lvZXHi02I43cL3z2590U9bUAlhXZ5FvRX
	XIOqcNuimosgUscEvy61LcCUzlopxQzarqALilJJFGkBI2dTNPWlJOOlSUVckXXSmVM7aKcr0pH
	H7mNdFZU1170dMI0FntvS7URFpDSfpRL+j8GWXdcI6pARxRA==
X-Gm-Gg: ASbGncuyLZOu3pMMX15iBjslTC5p0HPNDBj4FPf/g9OywBxhZR9SRtGhfy2lllJVbPO
	ww5cynMNSkSbDPV4KvlppWedtjt/Ss7DHdGluT1DdLQpDv03lY3PKmQ5EvODtaYALXan2HZ7Qh5
	QPYZJ7fy9C93LcHKQPANWnBgVV1rZ0uV6lg32jwL24smy5bi5paOjbSQ==
X-Received: by 2002:a2e:ad90:0:b0:36c:5c06:9aca with SMTP id 38308e7fff4ca-377979b3eaemr2168781fa.45.1760629846543;
        Thu, 16 Oct 2025 08:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSRrdF8ArqYripCAEOmkH6TM2FwiTHZ9QaNrA2Js9X8EEI3/RsDQOqlfKCxQcUBKxrBL5GCWIMhiINT9W0rHs=
X-Received: by 2002:a2e:ad90:0:b0:36c:5c06:9aca with SMTP id
 38308e7fff4ca-377979b3eaemr2168501fa.45.1760629845347; Thu, 16 Oct 2025
 08:50:45 -0700 (PDT)
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
 <d207997c-bd73-4dd0-ba0f-93b994b14196@linaro.org>
In-Reply-To: <d207997c-bd73-4dd0-ba0f-93b994b14196@linaro.org>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 16 Oct 2025 16:50:33 +0100
X-Gm-Features: AS18NWDyab7CrzMIo5gz9Gm4wvg6am-pveERf-dEkJ6bUTJSQqF1vXtwh2TYWEk
Message-ID: <CA+G8DhKUsbL1q_Av0MzKmJ2XdSpOJiAamrcqYjRekjMbcGtwDg@mail.gmail.com>
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

Yes. I had built perf manually from linux/tools/perf v6.17 so the
patch was definitely included.

On Thu, Oct 16, 2025 at 4:03=E2=80=AFPM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 16/10/2025 3:59 pm, Anubhav Shelat wrote:
> > On Thu, Oct 16, 2025 at 3:46=E2=80=AFPM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >> But the throttling fix was in 6.16, so I wouldn't expect it to work in=
 6.12.
> >
> > This is using perf built from the upstream source so the patch is inclu=
ded.
> >
>
> The throttling fix that was linked previously in the thread [1] was in
> the kernel though. Unless you are talking about a different patch than
> that one? And that patch is in Perf?
>
> [1]:
> https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.int=
el.com/
>

