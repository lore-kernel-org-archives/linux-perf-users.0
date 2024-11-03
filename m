Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFE23B0
	for <linux-perf-users@vger.kernel.org>; Sun,  3 Nov 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730613838; cv=none; b=B/i4B1TR5yVLxTCSeeVxXbMI1lWsqID4+GUzre5bQhqeGaolh2n56SQwVPvV1UQnszASoJDm8ldc9ueO2Nt+5aQIOUasQsejfjArZ/sho3j6EI5cUqouxygOJDkUYpvDZVeF8xGNqA6WJwoREv8V3ylDdWKGTicBN3MT9z8Tt2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730613838; c=relaxed/simple;
	bh=bHXtqm8XYFx0zqcvCE4R6b7YoEXGHnsANu6fhkd1DPw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WbZmVryJ5lxcWNoALBNt9cLWtry5LCFz5D9rdwsjiP6YXo4YFZwNVg2HVZidrW71KEikS9NUTekXUlrlZC0JBmk//wfBNuJi/kC3N+G+wns3J0AtPxVTOPHkPh/6UJfblYbz2on7IaChZ3A6NYlEhDvIcasG8/bJyoaL34Scrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKBTfVSD; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKBTfVSD"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso379305ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730613835; x=1731218635; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bHXtqm8XYFx0zqcvCE4R6b7YoEXGHnsANu6fhkd1DPw=;
        b=eKBTfVSDoBD1gGj6dkGRabD5QlwhSSAZbPPjjZkzXvyvKNONMqxUbPhi+TCKvPOvcq
         2uvM1ZjHXxLJ2rkuf1c5jyRfZoy8f4Xs97xHY84ehc3a7DSefkzaDb6Dc676hngoA1by
         Tc9rOkqa0M6iMMcWZKPS33BN9HeTfznyWMR8nCbq2EhoSB65Flrk6lMYzZhwFo3sat8k
         PZkhDEbXjSNqDeTatth1y0qK0TOvpJoALnH0HQKjAkBKPiTxOs1ABUyu2J74zYDGk2Am
         kOcCp02Ke3laQqlqP5I/V7f5JjTZYQMhFi7hl72dU4/G5bKXgy9ULTXnqShmOi0teFqs
         lNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730613835; x=1731218635;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHXtqm8XYFx0zqcvCE4R6b7YoEXGHnsANu6fhkd1DPw=;
        b=Lys9MPUrH6w2x6DAIsgW6pMif3tMxsi6kpoi6TKZlDyJK3LoCF1SBOe2bImrjsdEwQ
         TlSkPlJRdGozkLZanOQNnaMPyBG2VUHDW136XCxAJAxiIpSiMW0vXowVrQVMf6qVTxrZ
         gIvpS1QVKIvn0nSwQJknFnsJ8uRKrSiTXkQE3KCtTH2Pp/dgrug47LtpZHHNYpFpr32R
         hRwsizLaczU2eTY/El4NEfgtnCXWiRk3Wn0IzqaCkL2Cyd1QAMCQ3l7qaOz/UmTyahnQ
         rZNTEnUrKPkLol4wr0xdQV5rY4kwDRWVFm7ch/5gEcjq0k5Wy08DLVZhINgaKEwEx36C
         hWfg==
X-Gm-Message-State: AOJu0YwfKQBhIE3tI39r0BAK1YjMIkDcNkpksFMJeVZt8r2hnLmpLcGv
	EiNPonJqtt3nVDFl82h33ZYuY6WHkYnDABHZwnVkaQdjTGK4U8sbKjL4wu6hRxqeRwfzkgLlCYV
	HCp/YqvA6j6ET8v1ICvqgpLwVeqiFbxG3NYwXyjSLH20irIccg3lt
X-Gm-Gg: ASbGncuywZFYoBDpfzhGCQ/N5HKQd3VHBS8XwtNVWhPF1BzB2fb7zRpj/toD1IR975l
	mudmtiX9DeAKQgQIkBKiCteDhu6NiPu1g
X-Google-Smtp-Source: AGHT+IFgY1TF786I7IYW5Nmcx2eTvk2Guf/8tfzFNcYZAka78sPySR+jXDNyfeKkQHWirFa+KYIDoL2v6ISiTK0tQic=
X-Received: by 2002:a92:cd86:0:b0:3a6:b318:3b99 with SMTP id
 e9e14a558f8ab-3a6bf224acfmr3171115ab.27.1730613835228; Sat, 02 Nov 2024
 23:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Sat, 2 Nov 2024 23:03:44 -0700
Message-ID: <CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com>
Subject: Can perf record make buildid-mmap the default
To: linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Without command line flags perf record will post process samples
adding DSO buildid events with samples it will also populate the
buildid cache. The --buildid-mmap option is superior as mmap events
have buildids within them and the buildid cache isn't generated. As
buildid-mmap has been available since 5.12, a full major release, can
we just make its defaults the defaults for perf record?

Thanks,
Ian
