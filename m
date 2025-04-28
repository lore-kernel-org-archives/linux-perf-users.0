Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470D78F40
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849835; cv=none; b=tm2pM5MGOumyMBMQdWNo6LYtb2HzFD46/bAPN5o8aILTKUBSj559Mp9dWjXxUpsyF5NHhpxA62jjDBNiuyeJuBQgCGO8lfjQGXxonzqddyHWui/BYFfThJ+n51b6GQqQrV4+S2yGQJKZyBGuqWG1hUhbtMEoQFapSI2xbRWaa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849835; c=relaxed/simple;
	bh=TG3qiJ8FxpJ+JhDJyMQMenN08PNsduLpDMO/zg592Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjo3mAKzdzwu3CA3iwtFC6APQ6geopUn+sH1VKOW5e4GBZktLoKEfkXP8zAI5h8k4VX/4XGighvlAN1I+FsVuksDgmDMewKqPzhqq2//eaC9OKJm6LLE2gZkSdNewLOIk/pC4SCbKjeXPIJc/jTVFYYg3oh4MCb1jsblJlqcESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yp/WOBeN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yp/WOBeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745849833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG3qiJ8FxpJ+JhDJyMQMenN08PNsduLpDMO/zg592Wc=;
	b=Yp/WOBeNdQ36audc2E4sAVQCJid8UuGuXsI+cs6L7NmlpjowEqohRZbgCZiEiJTPGDlzmp
	CNR/XjXs9f5br/SmrNdFruciOLGIUoYOcBP4Y3P7YMQFMXmJ1q+bw3YgJdu8B3nbVEA2uN
	AMWXBj4rPGUJogkCuAla648TedwEqMg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-4X-V42rmNYqnXPBsS2l4NQ-1; Mon, 28 Apr 2025 10:17:11 -0400
X-MC-Unique: 4X-V42rmNYqnXPBsS2l4NQ-1
X-Mimecast-MFC-AGG-ID: 4X-V42rmNYqnXPBsS2l4NQ_1745849830
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac37ed2b99fso432467766b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 07:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745849830; x=1746454630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG3qiJ8FxpJ+JhDJyMQMenN08PNsduLpDMO/zg592Wc=;
        b=iesgLGSFddFL6r6nvhGBOH7E63tAYC9s75YqAcKyhscjqVULkHhVvYhCpZUys4CkQR
         Vlel6J6192mB47aEzSJbtzpI4fqkWRKxKaP1O++RdRlJg9FIXyS2zfdqxStHmSq5uwhz
         w/bDPdFKGyEOlF0Z4ZF/W4ItZMI3AHlyjD1P9GDooWGVDdMcs04ZS4NDl54/P7GyyNtk
         hTon61FYAlcOQhqiRCmS9XbPHJKQ+HCrKaHnb/yhWzxH1fHRTa1tsDl+D0sRcmSWd4u1
         Qcx5cp21OSfwW1onT9DlUwM9QljutEsPsiSxqjSrskuIa5ELeYA4vxVp4+sJACCL1pDR
         C3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0n3iUUa6J4Uw7/e8apdikQdhKwxsEK8Fr19Cd49P58CXGVsmwgmFAj9D9fCJRto6PMDfKagmI1LEIdGT7sYy9@vger.kernel.org
X-Gm-Message-State: AOJu0YzozCIo0Gb8BdB2Pg7Db43qlJHWSjZNn0+mROxHgE/yiE+Y6R2r
	9a2CnoP0xgBYabHv9ewJEfWcUK7i+w80xlWfBBOPJffDl6844i8qDkP60zFO5L1GjifToRCWx7k
	CUePzXKLKzWPkpwcijEfRbbRdStfZAslfgATSDmbASUi2sb/PGnXbQ1gMgDle6dtH267j9xeC9N
	+YOQd8CMIm4V+zgKrbxudeSGR3hIc2RpFarA+P40i4GQ==
X-Gm-Gg: ASbGncuC5SkfE0VRajyZ5XzCoXNc1BxsasBpcHKX1IizXp7ejqsT0g1ywLxvrWy9170
	TDj5Mj4khkOEBe4zOJc29WzKi4ZZpzI9S+zE/6qKcer2N9YaqTzwYCg+FmN3DY1Y1eugfzrdGBO
	j7cq/+XI46JzdaTrmq1AlfPgA=
X-Received: by 2002:a17:907:f496:b0:acb:b9db:aa22 with SMTP id a640c23a62f3a-ace70e91b4dmr1008719766b.0.1745849830104;
        Mon, 28 Apr 2025 07:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbJTr40xzov/JpEN1AZCFq/hEiKT9H91c5FgG1/zMnJuTUP4Lf2zreV1Yqu5sM418yv7kpmQlzPbxZhBEi5NU=
X-Received: by 2002:a17:907:f496:b0:acb:b9db:aa22 with SMTP id
 a640c23a62f3a-ace70e91b4dmr1008717866b.0.1745849829773; Mon, 28 Apr 2025
 07:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4=nvTab7BnT4uu0iCuFJpZ-_MdY-MYU+Q25QnpygEZKmsQ8A@mail.gmail.com>
 <20250428101234.GB551819@e132581.arm.com> <CAP4=nvQ_7oS5ZAsKmOd_ORg0tyHS=B+i2m63K=TLg22rTEiRGQ@mail.gmail.com>
 <20250428124727.GE551819@e132581.arm.com>
In-Reply-To: <20250428124727.GE551819@e132581.arm.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 28 Apr 2025 16:16:58 +0200
X-Gm-Features: ATxdqUEGAw_xe9AuQufWCZ0vkmil018tY3jNyZt-_SnQ-ewecW2yh5rZ4pI92sw
Message-ID: <CAP4=nvTdD=eKcO_sJL3G7U0KxRTQ6XjJeJxNrmeD3n8UGBv5+g@mail.gmail.com>
Subject: Re: [BUG] perf segfaults when combining --overwrite and intel_pt event
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Wander Costa <wcosta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 28. 4. 2025 v 14:47 odes=C3=ADlatel Leo Yan <leo.yan@arm.com> napsal:
> I would leave this fix to the Intel-PT developers, who know this part
> best.

Makes sense.

Just FYI, I tried applying the patch above, and after swapping
mmap_ovw for overwrite_mmap (which appears to be the correct name in
struct evlist) to make it build, the segfaults are gone:

$ perf record --overwrite -a -e intel_pt/cyc,noretcomp/k sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 40,533 MB perf.data

However, the data cannot be read:

$ perf report
0x7620 [0x30]: failed to process type: 71 [Invalid argument]
Error:
failed to process sample
# To display the perf.data header info, please use
--header/--header-only options.
#

Data generated without --overwrite is fine.

Tomas

