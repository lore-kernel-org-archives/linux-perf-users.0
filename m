Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355E21ABBB
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529351; cv=none; b=Yn8MPk+QAETz239wHcnZ+E8FZMpAi2+PVR6wzW3Ix6akHujKkGNGPrtGOSmg9HTCVOrFS0xFQIt7dl0NQwG1g6OYfOntRga8A5G+YWSamVoZ23FoGz/FwK6nR1NZhLSFCCV2y69rqzFNMEoxWgKRZnkSrM2jZVXx5+SPbPPcUjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529351; c=relaxed/simple;
	bh=5HRU1916V7EDad+LVmB03KBxNjqkrd+C+UTjhT4pJuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYhxirEJjNm1u3EJwlXMc/ueqZzJap0mbCsjKOYxoKp/+IrSSzFYc7UnFZVFzeYYkGtTqfmMxK+RIZmYwfIIbs4g4hAUHUIsBIlLZV2qmhTtPHAc4qBxfZXXy0QGWfWTKfrV5KUOL6fE3dCRthh3xiRdcPU/6pbXBzilEo9SdIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcYtO81v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcYtO81v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748529348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3MCFV+ZoZVB2oSCQXdN/eZND9vkzq+izak/pnvW1n0=;
	b=EcYtO81vV1QB+Yq6KY/te8EcDCOAfFabgtddPjFkp1iA20hyhBNpWiay1aByEhSE29IUTt
	k7sbAqNMHaNmwYYCNUZKWed8Mo8DOv13DW33gjTApB6oZ9ErqtIrRlC3hgTJ+949N+f8Zb
	3nFI/d9U2I81OO00Xm2IQv1Wyd+GHB4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-vuKfc8DyPcGQDFNQTBMt4A-1; Thu, 29 May 2025 10:35:46 -0400
X-MC-Unique: vuKfc8DyPcGQDFNQTBMt4A-1
X-Mimecast-MFC-AGG-ID: vuKfc8DyPcGQDFNQTBMt4A_1748529345
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32a6c630b70so9552951fa.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 07:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748529345; x=1749134145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3MCFV+ZoZVB2oSCQXdN/eZND9vkzq+izak/pnvW1n0=;
        b=q0GeQmgDSEpZ2iOODFk1wySpJTVdo4XJ2pmfhckV+FGmC2SlyN0+nHrLsZrpkbHcme
         1Y2tNc0jkJ+sH41bJUdoIZwlHtnFNm5c0Qy2ESTTWE1v4tNThb4EYhzJ8x8ugk29CGvJ
         ElGSfUQgsCY6Z3QBy6ji/yBWB2N+YEsAvEWY8JEAyYrmnkGojImHoYzKxK58MMOwMXuA
         g1aDCVPpryE6PfiRoRYWZIibwfs5Vm6ylF+QfOxKWJkYMOaDmwXTPNaeKJ+X7Y8pSNwT
         z8++Lt8o0uCrhYS9zHik91Ft3Th0Ld0mJgKm64sB8dny+FyzMOyxeApFxkznGdUTQ8an
         8Wkw==
X-Forwarded-Encrypted: i=1; AJvYcCW61cvGdbzxNi9AC305xhvuIZJjK1E+rNUMqACwGV1sjWCFgEo0SBdWDcF9dtVTrFx/0ooTzTO4/3uF8mTdNLXF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9dhYJA+19Vf8wJ9kXjS//Ng81pE+feazPnou04KTl7iWFKpb
	V57rCmsff6Smz6xqyJpkeudd4HWOjSbRNBmdZslGwjDpGoIt0uHrqW3NQcqJf8Ty2iSerdWSWF/
	tnrhv8PPlfpWOIPCOg32wMOasexUlzZZC7ASM95CqgZ/nsnMOUiuVLow5mbw55199KIqWomUCax
	Ai+CP6bJJMw3ShVioeOHroFgdY1QLZPwAjsGmB2vkXfna0xQ==
X-Gm-Gg: ASbGnctqPmLoKzKyxvloYa9S/pKyej98R56kYqYKq9Td7hKqyGEQedOQXlcvJmWVuZr
	wiCXwOFJ3iTv6DIdIv/fyQMvsXHXrHcBCEVRiteicKCpto1tpkF9wFxWIN2anLob8oS2jZQ==
X-Received: by 2002:a05:6512:3095:b0:553:2edd:a7e0 with SMTP id 2adb3069b0e04-5532f81c2f3mr2712165e87.16.1748529345232;
        Thu, 29 May 2025 07:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZUPxRsnq516tbw1KHLqgx+uGG3jhNGo1aJuzLabfZyp4DEFJSBLGRdE2ouwQzDloFOdI6Rqsm7+lEA8E5PJQ=
X-Received: by 2002:a05:6512:3095:b0:553:2edd:a7e0 with SMTP id
 2adb3069b0e04-5532f81c2f3mr2712156e87.16.1748529344856; Thu, 29 May 2025
 07:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403160411.159238-2-ashelat@redhat.com> <CAH0uvoh8h2NAw3wbBwXAKyAHWS=QehM=pkBD8GOc+f7CcmedyA@mail.gmail.com>
 <aDdYxLLtNa4qT3ZF@x1>
In-Reply-To: <aDdYxLLtNa4qT3ZF@x1>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 29 May 2025 10:35:33 -0400
X-Gm-Features: AX0GCFs4Q7mnbUma7UttiEdULe8tNbtPjgdp03ftJvRbvvEtN7zsO8EwHKjpUDM
Message-ID: <CA+G8DhKiamF_AdYgc6uzGUWPjg6YvePUb13T4v-Nibyab6YREg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: always print return value for syscalls with
 set errpid
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, mpetlan@redhat.com, namhyung@kernel.org, 
	irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sent the second patch for errpid.

Best,
Anubhav

On Wed, May 28, 2025 at 2:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Apr 03, 2025 at 08:26:52PM -0700, Howard Chu wrote:
> > [Resend due to rejection by mailing list]
> >
> > Hello Anubhav,
> >
> > Thanks for doing this :)
> >
> > On Thu, Apr 3, 2025 at 9:06=E2=80=AFAM Anubhav Shelat <ashelat@redhat.c=
om> wrote:
> > >
> > > Currently some syscalls that have errpid set to true do not print a
> > > return value in perf trace. The syscalls that were consistently
> > > observed were set_robust_list and rseq. This is because perf cannot f=
ind
> > > their child process. This change ensures that the return value is alw=
ays
> > > printed.
> > >
> > > Before:
> > >      0.256 ( 0.001 ms): set_robust_list(head: 0x7f09c77dba20, len: 24=
)                        =3D
> > >      0.259 ( 0.001 ms): rseq(rseq: 0x7f09c77dc0e0, rseq_len: 32, sig:=
 1392848979)             =3D
> > > After:
> > >      0.270 ( 0.002 ms): set_robust_list(head: 0x7f0bb14a6a20, len: 24=
)                        =3D 0
> > >      0.273 ( 0.002 ms): rseq(rseq: 0x7f0bb14a70e0, rseq_len: 32, sig:=
 1392848979)             =3D 0
> > >
> > > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> >
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
>
> Thanks, applied after rewording it a bit to mention that this not
> related to rseq/set_robust_list as those shouldn't be using errpid, but
> that the problem predates that and added this, where the problem
> started:
>
> Fixes: 11c8e39f5133aed9 ("perf trace: Infrastructure to show COMM strings=
 for syscalls returning PIDs")
>
> - Arnaldo
>

