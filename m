Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88949B663
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023394; cv=none; b=GiSWofRkYo9EDRRZRN0EKUDovI1pVn/ApYx1j97KfiVxlgYeJqsaxIAcIesGVGa16cvYdgWvycBzusnr9U/o+Zygy63N4xDK0KTsogBuo7vxhsptfZ4G6ej7N8hpijF8y+x1Fba16qEFKM9yGux5a5HqvnfTL4xHMPEupFmEDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023394; c=relaxed/simple;
	bh=MJFiOKnb50yHXXmJw6v2r67v6JzEr7Pu+ziuNKiQ750=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRGSsxGNGVQbC5txeoQXYWqKww/GYoBW4jKGwWK8fRcG0SnPBpZuKpTu8VQhcWPFVqxmH9Jp9ovsu3ZyCZwCmXy3eJxtKzAIn9f0MjvvvEdCV9oz1NROq6hPIhx6FSzPRX3xaNc0Ki65X/HA7NqF8ItqWcjp7ThMH39V/ThPnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFGWqteb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFGWqteb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760023391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJFiOKnb50yHXXmJw6v2r67v6JzEr7Pu+ziuNKiQ750=;
	b=fFGWqtebc3TVpDX0ymhPjsKDdv/myMwCo8uIhSPakEKdYQxhk/c7JKG9aMtzoGG76eYKr0
	CZn5FwWVsTw8pKgoaTejphH91oB8RGYAbXyyEnx+VN0lFFrGEt8lFbU4q31lv8vVGE8tJv
	MgtC8PmHKmsBkLuu4erx0oM3dKq+K8g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-CJtmOZRgMLCb5TpBuV5hJg-1; Thu, 09 Oct 2025 11:23:08 -0400
X-MC-Unique: CJtmOZRgMLCb5TpBuV5hJg-1
X-Mimecast-MFC-AGG-ID: CJtmOZRgMLCb5TpBuV5hJg_1760023387
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-369b2d355d0so6152021fa.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 08:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023386; x=1760628186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJFiOKnb50yHXXmJw6v2r67v6JzEr7Pu+ziuNKiQ750=;
        b=uBUzTIYM55YMgZ2hVjSxdsPv7iLv1Zan/aMxYB07HVkX6NtddEGPKVJ+tNzK9mxhZC
         PeUmtVAmvs7FvHZUFIN+zvkx2SnuW51fP1C0l6UZ5DShLpR9zE4f9PJheXtmk+blcFKW
         zJfy/cP/Bz0LaTxovWlnUQwfYrOFF35zE/9AocR+D17wwbeMLfmQPiTn0HUyk8U/eiff
         zFNgCfWF+ZjoYYJybgH87XrbeCaL4bSp/0mKDPTeBHHqU9YdBCFL5f1BPFpLBdaIsGAj
         5TafZZHz3vaFYafptNUGy0Yfdxb1G7/7gMdnffMo5IY6T/asVzKXFej2ykIhG88Wg3Wq
         NEww==
X-Forwarded-Encrypted: i=1; AJvYcCUEAhtIqGHfTNXh1wg/29+LZiPs2SvA+OqkLt3zSnri/gT6gziz81cKYrrGlaTzvKTVtGmG9kyEo67ExYRc+xHW@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3OrJE2dI/oGXDvW/NyiwP+A4Qu+hcbSYHNkQUpkJsyEmp42Z
	UERDqjWGGl5rHlHhco65i1SIT+/pKm3Tz2ImYx8FI2lhMk0P1cswpgwwz8qaXCdzgycxCr9peIO
	N6Cl63NU3fvfal26226RWtslmliBBdcSFT2SQs1hWvpZesCm/Qe6P6PCYMWGJYmOxMBYl7j9DHo
	3zlMALlcaUbw5azAnPO0ThApfGenKHWpbfce6n3lRWVJSA3w==
X-Gm-Gg: ASbGncvVxWEOk3Fh1xKKodvOyu5+xlC+x2P/kl2pha+MVxTDxy6CNLwKVgPVfOeR8H7
	gEcX5Dv29WGtqxJTh6qAoKJXKlHIwvCstaB10NNoXcIHlpcf15W3VViD1odTJubAameFUQoaI+4
	I5nozTppS+hc9p2W4216xel1CK
X-Received: by 2002:a2e:bcc6:0:b0:376:2802:84ac with SMTP id 38308e7fff4ca-37628028b0emr5484581fa.46.1760023386525;
        Thu, 09 Oct 2025 08:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+CQ++uJDYnzwvibsq4vWNVCIaKGnGLPwjj8X8WX4KDR65G6LtATG1bxSca6Or5cyXD86H+HapOAqGddQ58Js=
X-Received: by 2002:a2e:bcc6:0:b0:376:2802:84ac with SMTP id
 38308e7fff4ca-37628028b0emr5484451fa.46.1760023386110; Thu, 09 Oct 2025
 08:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001195047.541745-2-ashelat@redhat.com> <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com> <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com> <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
 <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org> <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
 <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org>
In-Reply-To: <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 9 Oct 2025 16:22:54 +0100
X-Gm-Features: AS18NWCXsDnxcv0-cnyVIwc7bM1sEtpiXMZzP9S4ESMVLtPTpGj6oTIBYgWgLDQ
Message-ID: <CA+G8DhKiiHusKbJ28oNH3Cofa49k_H+yLoAc9+Wt3KQYWPOg6Q@mail.gmail.com>
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>, mpetlan@redhat.com, 
	acme@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, dapeng1.mi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 4:00=E2=80=AFPM James Clark <james.clark@linaro.org>=
 wrote:
> Also what hardware is the VM running on?
Both were running on an HPE Apollo CN99XX server.

> That's assuming that we've agreed that any difference in cycle counts is
> expected and valid. I don't agree that's the case yet and I think it's a
> bug. I only see identical counts, and the commit message in Kan's fix
> describes that the values should be the same for all architectures.
True

