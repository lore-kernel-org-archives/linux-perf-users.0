Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1381A3A80
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615238; cv=none; b=bs0c1xOetUfvlOgAaUKTSmaqrQQM21E904OJ8iefT3wN/6LfOrfnoqoH0546H6i12GFJUEb2cSFzYuYKay13LrthnSrY6rTO9O7D3ZUZGG/DYkjjb7Id5bgc2ArSnjMUy9MYrVDpXnIgXiEbmT17Ps0cm8BsKHJXKSk9O7gqJdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615238; c=relaxed/simple;
	bh=TNqWhWOlM2ada5heeqf1MTTXgH02g24k6W2FomyUWaA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q1VqDR+euy5JqIjcL1en/eFWoIq7jyZbLfk9BXrOhyBlG/ItxfBc09H+0dJ5H9yvDDUTgO5z2EV7f9Sd+SGz0JwGrSI1ypU4tWce8zN0Dljbsq6JBs6rDaZ7qRzFBuh82wsBorKa+W+tlNOQ1c8XO7Zc0okv2e+OV3ZKVZy5+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgwtoEfS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgwtoEfS"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2e508bd28so45128147b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729615236; x=1730220036; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TNqWhWOlM2ada5heeqf1MTTXgH02g24k6W2FomyUWaA=;
        b=dgwtoEfSMke7OmynZUvNgluH0fTfThf+O1ggnLZP2d7LTCSBnc8T2n8ScPfzrZYkuU
         16eKXIjNXFKKHvID7O4LJCDS6boTnmkl1X6ngCdCx6j/mQikHtgxe7cSc9JVnEHMVE4/
         ogQAzws9nmio3G+j6NeCoTlBV2FGnXiKS6TVVNxjCAzXoTO4Enb7Lng/iMP4uBh60wvi
         cjL5+pP/H3Z3ju+1TAyuM2lOJi41KgKXonMCreB7zxYklFmkAvOxRYF9M2z/YtPehaKY
         muyDy5MLjT9L9HfYFSY4vfoIZdhflofsXYtMs3cPHwxIbeFqL3Q9q7EfxC+jHOcA/8BT
         xXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615236; x=1730220036;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNqWhWOlM2ada5heeqf1MTTXgH02g24k6W2FomyUWaA=;
        b=vFWfvjfAzaOT4nhJWxrH+jPzKaMHsBgA2T4cgEY+9iSDtPADMRHATSTWx+8lBDKasG
         cgI/fDZyAFc+Uhat1kv4LLru99WUzhiaE9kjINuLSt1T6opgiyUViuTX7hlZxIS+zOvW
         KvW7ZjaVLqlpi91EN8DHQTxbwDC+DgwSFTpLYlIZ8i7AVCl4vrqS1AlQSVM67E2KdxZv
         S7pQmCqkA08+S/q7JyZAOBROnclDruQSNF4FViLUGajPUlH+Bxc4CjnjI1DLVOVhDxVO
         DuVwCTbzjlXBW+qluMogzt9ETd/9xUAykHDBEK7NBRBXvX3CtnN0MGi1a8lnmMrahMiC
         L9FA==
X-Gm-Message-State: AOJu0YyyHhLmb3nt86AQv9OUvg/GZ7MYHyxtFAPbk77ZqhTEQo9wlglJ
	eX2mBNsdeH9keGXldABxVvTV2NH72TAob+vIcy3e9YL0J+ky+xiUHDbmrQPNwEvXOZ6lrap/VRR
	ZB4wZk9E8FZu3w7hy26KLa+Eh+eI0Hl/W
X-Google-Smtp-Source: AGHT+IGWYyJiuRUI9IJcZJY83drcvyKDjkX3cImke8Rjoi+TxAxzzIDvaCWXfxl10v5//1WgybDvTFtwm6CIVWRRQKI=
X-Received: by 2002:a05:690c:d8a:b0:6e2:ef1:2558 with SMTP id
 00721157ae682-6e5bfbdb7a2mr143630107b3.8.1729615236311; Tue, 22 Oct 2024
 09:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: laksono <laksono@gmail.com>
Date: Tue, 22 Oct 2024 11:40:25 -0500
Message-ID: <CALwKgup1UhiKMHvEni_3gaWoC0BLu8kkT6R=7R=b-LkBx5_3ZA@mail.gmail.com>
Subject: Intel SPR: perf-record doesn't support topdown events?
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

All,

I am interested in using Intel TMA support in Linux perf. I can run

$ perf stat -e '{slots,topdown-be-bound}' ...

on Intel SPR with no problem, but running with perf record doesn't work:

$ perf record -e '{slots,topdown-be-bound}' ...
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (topdown-be-bound).

I suspect MSR_PERF_METRICS cannot be used in the perf_event sampling
mode. Could someone (probably from Intel) confirm?

My Linux kernel: 5.15.0-86-generic #96-Ubuntu (just in case this matters).

Regards

Laksono Adhianto
