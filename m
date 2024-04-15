Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CFE15572F
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207021; cv=none; b=NzsmYeMpwg438l+Jt9l0H4/6g/7fHwZDYxvKeewHkhlIPX63/3TaiS4xGI1ghcnOBUHduYzMc3AWCQmrl1UzcQvEdKoJMHju6Vq8Jts7ub1YjLWDVZ5tX/G8v5agf5qjlGXN7YaR5NGcXWmPH9AWeN+RGOeM9jx6n65SGowuTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207021; c=relaxed/simple;
	bh=Ba8DIEAj9L20L35qU4d/IfJBZB22z9BdkIrA/sX3Izw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fUf8yJ+3kMBRMpmmmxnnoYbHdpzb3gIZPlWu0dWoJXEyiny9q5KvwwaGdHH+0l2C/IyUxNMW5SGXqRLYa+xs2g386jyjMulPT3vyd4M/+f6QcHhFYKWuQ3G+pBIt/5OP2/m6Kmza31mdcE4TMcwyXbbuOl9hS8culG3obk1LL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O31qmyW7; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O31qmyW7"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2348116ceb0so939723fac.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713207019; x=1713811819; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba8DIEAj9L20L35qU4d/IfJBZB22z9BdkIrA/sX3Izw=;
        b=O31qmyW70i8TqHFbIH/Onkh3ZNtXwrUAXI8sDz3dhavcTvara5hf18h/HpOmBnkiA3
         qDFifCskwBmsNAHOUdCAY/oWNTzIV5V+JsMCv0p2S4opcgLY+IjmHzTkuwqf93jwvZC+
         pst8SJ6knojO2mPEK0tGvz9shu3uJ+NQRJEqRg4gt2AgbrYjyft/Ap8kxInJY5d86xMN
         EFeBWg/cc/iUnXBs7ZK1h/3SpiJsFNB+7cZjbvR056UqlEoQWhWjupMNFj6dekhJjp56
         EapEnTuWb5va0zBDGFnOHnYbxN8HJDbIVTSsyL0pnE0oMvYmlblHjP2KWVkoctMQO2DU
         oxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713207019; x=1713811819;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ba8DIEAj9L20L35qU4d/IfJBZB22z9BdkIrA/sX3Izw=;
        b=VZwfBwUIkyRmUkow7urxFAEm/qfoah9K1JRnWU25yuSSaRZqy3c5DxH/8tsPdGWHYD
         5dQri5drGqSwk0Aj1i0vDHmSmeV/Qu/qSPQJVSZOS9fj+KLO60HcQL1CDDAEvOUDZrci
         wB6qXctremirhdZLTkJDoljYbpqgGvcf+V7eT0iXlyKkTU5eq1jtnTGwFuEFtbx0ZnyC
         5JRKfmQ6GiE+1PCdzKglPZePtK5FndF+InNPANT7AC+6Tb45zQcXjwSLjVNIRar0IkIy
         kOnxZPj7FTvHIR52tIMZ98fBoC6XsfR04HotSQQcgvH8VC5KAWHSavIV0Y4WweBdWpNn
         Rjzg==
X-Gm-Message-State: AOJu0Yymj023cY9z6DEGiOh5Gx/XNCnhfaQlEzSrGwyRNbrYKLXCN8+3
	4TtvBP18zWnNuuJifnwoRwMit7mMvGHt73wJiiG6ZIJWM+dppa+5MQ2FO8ZajU0blnEYFZw9Az4
	2skilfC4nKxDpSnSxMNp/cw3HuoTbFy4i
X-Google-Smtp-Source: AGHT+IFfsue3XkB6FAMrZygWfblJN/k8lJKnQftU89hW/UbyfUKdJ24Kw+/caKdxJKEfrdVKvsI9O5i1ykheifnie7U=
X-Received: by 2002:a05:6871:5893:b0:233:5570:a2c6 with SMTP id
 ok19-20020a056871589300b002335570a2c6mr12803913oac.12.1713207018922; Mon, 15
 Apr 2024 11:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alan Egerton <eggyal@gmail.com>
Date: Mon, 15 Apr 2024 19:50:08 +0100
Message-ID: <CA+phaecbKJXE56ExeJUA5c2=tc3m3p8iNefuqyjs9P3kOn_aWg@mail.gmail.com>
Subject: Percentages reported by `perf stat --hybrid-merge`
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm struggling to understand the intended semantics of the percentage
field in `--hybrid-merge` results.

I'm looking at both the `instructions` and `cycles` counters on an
Apple M1 Ultra (so 4 "apple_icestorm_pmu" cores and 16
"apple_firestorm_pmu" cores), but with `--hybrid-merge` the
percentages consistently read `80.00` (which curiously is the
proportion of cores that are firestorm) instead of `100.00` as I had
expected.

Whilst I see the following mentioned in the manual, I can't quite grok
how it applies:

> perf-stat reports the scaled counts for hybrid event and with a percentag=
e displayed. The percentage is the event=E2=80=99s running time/enabling ti=
me.

Could someone possibly explain why my 100% expectation was wrong and
how the percentage is actually calculated?

Many thanks,
Alan
