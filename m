Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E31A0728
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626809; cv=none; b=Po5muWuhqZk8TqxfN5ZZev1P5Fowos6wY0KTVbkYSQpHBGv8cgAxAEuNoITOAq9uhBnY/5TZMUn0RXVEw+DWRJxiwpQK9WwgTVzDeJ2k9em9iYe3sScWDyhIAJlzu69ahpqEYy8xqo2pt0Yen8vU9fOzh7bhOO5SWekZIZUzOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626809; c=relaxed/simple;
	bh=K6Nr+qsP7ddYVMM0xNSFBM5D76WG3DIjGyDNsyWN+oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3td+CIRmF+I34rKMkh7/camiFMpZvkbmcp4HQu7TZIgnf694SDQBBuQ47v+7HQT09vioWqUh90ubD2R26AgQrg9qSiIYF32midUNpr74YDYLnTp7b1ZQpUOEp+17b4dKQOpZ2ak67+0M2iKks3WX9fC3cayECJ+oltvqXopDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsIZEBxA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsIZEBxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760626807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6Nr+qsP7ddYVMM0xNSFBM5D76WG3DIjGyDNsyWN+oI=;
	b=HsIZEBxAZidwRaIaYvfCN78YHjMCq48sq2ZS7MyjS7H4NlIqIf67PC2bJpzVTO9mry4UfV
	hjkuCPfk3172pmslL0ycO/E/aXmSYocJvMfSWYK2loR2IADJn/Agh5cOeAv22SxeEtt0+v
	5UjuwYYqkWZetNoczZyVd140JLbIHXA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-HbBzwjUhNFu2Co7zw4BVtw-1; Thu, 16 Oct 2025 11:00:05 -0400
X-MC-Unique: HbBzwjUhNFu2Co7zw4BVtw-1
X-Mimecast-MFC-AGG-ID: HbBzwjUhNFu2Co7zw4BVtw_1760626804
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-36b57abe6d0so10110401fa.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 08:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626804; x=1761231604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Nr+qsP7ddYVMM0xNSFBM5D76WG3DIjGyDNsyWN+oI=;
        b=HhqV4eFUgi1jwxmjGr8DJZhrzKt6CKdXzucTAUbVkbb8UAxyX5Ocwa104D4sQGGgdv
         jAruWcT59pIYhhNc+kYBzl36LAthJRL6va3biF0RV8ofroSTQZEcFVaZI3XBixlgcduc
         Aenc5tI7LRTxMF5FgJeWASwBGumsAR1AonXx1QvT6+4CT0BbmshFc4DV5jlQq6lsWnC/
         zLVJEICcx8x8FZf8tj70RboZy/pn3twBwtjLm6G/3MsQqkRCuFm2nPShrBwjt5gx6+U6
         KTbrvRGETLdyNaqpkdWcd+dUJtOYtoGUG6JJ0kqQmBpXbqLLCn7Eq+SiRClBfpjOb5A5
         Y0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUuGnn5culdbEvwVYS2bxuH9Pcq9oexPlCiTwNQaJJrmdMgWg4BWorKmqjll8caqMq5mpsArX/ejlmErSJGuoew@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJLsZR7REcykSIDcmG2h8sXJSh0Z1hVEPqZHCSgC44uovw7Pk
	KpZ3RNMXvJxAlh9mpu9GE3uQy9KJIvnfVNmm7I8SVd8wMfLi9WJvpswg0lucvFOlewZzntBlGtX
	DTJyuzZIQnia1emsxK35kBCvaUGUl/AzsGPBUxz4ewTgY+V3RcHqHb9k4TFyv3N8qIWnIQ8yZD3
	M/kUo3LtGbjrka4jCRn4kfv2Vf34p+AO1dzV1sX8RAhuZtZA==
X-Gm-Gg: ASbGncvV4RJaoTVlEGDaez54scnYywphKMGXZL8JeKanDgz0rvntvhnJhn28/X8AhVZ
	QUKUm8dLxy/0XRQWZeaxIwAr4syPe3kBPQaWDp9eXfRIEvYfLImSrI2Dc9Fogbs5reYT7ZBFero
	0W2lIfG07nElq6fPFpcRJw3f3P0R3y0P87iRYZ+Dmoln8aYQfZ1uvasQ==
X-Received: by 2002:a05:651c:892:b0:336:b941:4ab1 with SMTP id 38308e7fff4ca-37797913c27mr1831311fa.17.1760626804144;
        Thu, 16 Oct 2025 08:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbb+8fYXwR4t+LQuCqpMvTU6vFmLTDZGJXQ2Z7+N2DICe0iWwBA6TmknQMi5WuWR5T1a5uWmb+9VrtS26Zi6g=
X-Received: by 2002:a05:651c:892:b0:336:b941:4ab1 with SMTP id
 38308e7fff4ca-37797913c27mr1831231fa.17.1760626803720; Thu, 16 Oct 2025
 08:00:03 -0700 (PDT)
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
 <abc1cb61-8169-4a26-9daf-264a6d94cc84@linaro.org>
In-Reply-To: <abc1cb61-8169-4a26-9daf-264a6d94cc84@linaro.org>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 16 Oct 2025 15:59:52 +0100
X-Gm-Features: AS18NWDr8g9YgW2fcFUYTzCWzUfKrF5sSEB8D-wLBrAqCpGXhfEZ92cTM2779-g
Message-ID: <CA+G8DhKDeg61ZM+Pzurnbvvs0L=mdxYhZZTMqfri1wf3AnFaeQ@mail.gmail.com>
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

On Thu, Oct 16, 2025 at 3:46=E2=80=AFPM James Clark <james.clark@linaro.org=
> wrote:
>
> But the throttling fix was in 6.16, so I wouldn't expect it to work in 6.=
12.

This is using perf built from the upstream source so the patch is included.

