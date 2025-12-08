Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73872E62A6
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184718; cv=none; b=Zbb0fI6owSeE0KdcQHKlhy2/T4aXxrTfHdLzQmgB6LL3yfyfx92Ypkwzs3C/jO8/X7FmuWJNZGCIq30n6udfOjDlNBllCtbyPJA3gJRpXjZuK4benM3DoBEbYS2+vO7WhH+5w8S4YFDXGQZnBCiAcaav3Nm13Es9Ju8RyQKI5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184718; c=relaxed/simple;
	bh=99Gq8zaJQDzmh0rJ9SfN0AY30f5+FLcQmxa4EMt1/ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPtQ+rbQMSznJegnL1bzYc6F0YDAfgqHB4458958qfiESjeECfKkpRqxXGq8PGf+SUn/c3rJX1cxOrjS8s1Bbxd3zsORJnjQ74C/wjluAon+If+FtzM/XiUty3YV/ZfK26to2ugeUyLo6xQV9nc3B9c9X+ekk3Ii6cQTNGOoCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIvU9NMo; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIvU9NMo"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5957d7e0bf3so4790620e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765184715; x=1765789515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99Gq8zaJQDzmh0rJ9SfN0AY30f5+FLcQmxa4EMt1/ss=;
        b=WIvU9NMoR8TfvTa0v4Yqi4Y0TjeyWd/mhZGu+vBGEdngDNy3LEtwTKzINT/dIvGYFL
         wiLvRpbdnXwIeLDjH7T3xOMpo9O+S0xP++dACtQ0aar1dLlcQ56bqhhMImxmXPnOLqPc
         C1nTwGZdFYRck8nusqChppr4L6c0x8dbR7LYMO6i9mMVahgIzkhVeKTnAYZU3VeZS8O7
         U+7Bt42nyqdxTbEZTfyLzgShN1JV4m3O4w+yUSI+IGGwxI+HHARpJNQ0QvKhpmKbmt7L
         Zc9kD9LHiHCMKofJEcqDsC8EzTb3CjDDhVkCXNcHck4EdQXuMrGb8ljs19OoygYRC5Bp
         BXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765184715; x=1765789515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99Gq8zaJQDzmh0rJ9SfN0AY30f5+FLcQmxa4EMt1/ss=;
        b=dlCzVFd3ALOnolcjTMDVZGcS4JI5gGaUIeskkZMFlq9+ladh+rkvrtDJxB6RkYSsjM
         3x16BDAoFCs3NvVHNuVJwiThopq+oBf7IuRC+SUwAgcbSH0hTqiZSSWzMWt6gL37T9i1
         yFwEdiqE2iuDtiWV+vYRDhcIcTtuRvZ2rn0hq0icEmd7wC49CAMZeLVCqkp6o2KPjEy7
         LvMfcH8Q4W3TEk1WedbaOYI0Fwa7gyiTUyxQbrft+H+dicRrCcRXxz0pMT2y2tjP8tVR
         MIvm+xPsm3sa7RJW4SNibbldbhmHesWOmTXAk/LDuF+g9H84LOTxnqAxY6Nwa4sXE7q6
         VvMA==
X-Forwarded-Encrypted: i=1; AJvYcCUMN9Sva+T0jzDN+wfgW3thS/kUa9WTR5981E0UFw2gno7lHiRJrFbHynhbSudLqyjkwxwm/Gjny5bIUe+P9b96@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrNJrUNsdEL9O8dP0NUEPr5U9fQTXQZkCooURsoIrmaH+gDvU
	tHM9A6ooW03YtzrkJnqDeWqs2eU9y5nqjxlxHmu+kJIrvjcaY8rG7cTqReEwryEu4kaiKDh1Jsn
	/B2Vl+DRcE/nnk01ZyrQZUY/PcnLqkjk=
X-Gm-Gg: ASbGncscasAY8RjyZi9vf89fLaooVYgOcy9l325/6S3GofS16lWSwlffCUGLu9K69DC
	FrtTgv5PQM8qpwMyyxh4vpnNsxQ2056vcD6tpbjBj8M9WqnWiz7P6TGqtoDTPoB0C/ab2W/G5Mu
	+CbrMRtYVexDPM7QuMckpHU4drO/ozGpj8rh5DB8D8uwrTA8JJ6Ijo5sz9sQkU/ApGG+fJb3gZS
	PibCIsudRqQK4EvUju5NPq0nBTWdEQeZtzC4P7LpWWaaU3VCcxS1kF4KTx2zoM+Po8+vdVy
X-Google-Smtp-Source: AGHT+IHw978LL5v8F3M8ByrrcF8eWKtoFY/XSlMZH9QgKBNrBP2bu2M9EgMR2vDcGoiVjTBkyT/hQp3B7dVBoIz7SPA=
X-Received: by 2002:a05:6512:138b:b0:594:27de:77e7 with SMTP id
 2adb3069b0e04-59831c7b141mr2218247e87.15.1765184714722; Mon, 08 Dec 2025
 01:05:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com> <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
 <20251125161026.GF724103@e132581.arm.com> <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
 <CADHxFxRdqBFq1c7wNViP0TRdopCCw+9y+hmaU5wNZLodKBq3Cg@mail.gmail.com>
In-Reply-To: <CADHxFxRdqBFq1c7wNViP0TRdopCCw+9y+hmaU5wNZLodKBq3Cg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 8 Dec 2025 17:05:01 +0800
X-Gm-Features: AQt7F2rDTqoyIjfMVK4wPTBTcrc48pJ78BOhuR77Kw6LCXNbPnUA9XXGTrptPGI
Message-ID: <CADHxFxT7dgpAZSM0AwcAs0X-w6H+iLRN6y4cLE=ERA39gQqKsQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

RESEND for your attention.
