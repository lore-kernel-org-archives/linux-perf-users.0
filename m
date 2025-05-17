Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9EF101C8
	for <linux-perf-users@vger.kernel.org>; Sat, 17 May 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747495788; cv=none; b=ZdQZ/a4lKkPxaYCHEu7cf3COpOuSRgOYh2jB4HXjDxZeQvV01oVTuvji+ZfF74D/2X4bPr2go/s8Kh5EqinbK192Z6E4GSL+VAemIUsF7AFmvcRAyRZEnDB49ltKlWWpeyREGP5buy5oZKExCxJsIV+3+KtjOrV5W8y5M1N7QvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747495788; c=relaxed/simple;
	bh=E76WBjaIXE7yacVKMjhiwfWfY1MnQgFTPSKDJiMs9fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0eV/W/tDIjxG1bCwnk9cSU/vIngSZSbJjRd2+1f+koiawFuYVIEt0+NoClwoZzD9hykKVT2+p/CHR3rzF/lYYfvXAqmagxrc4xDF/v/hGEHE+hYfvMB2vg6Xp5fnoA7o2/uOjKdC5Xcym7YGkIxBh7FNMaRaJk5SEvHkB04utM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioJqMfZO; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioJqMfZO"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e732386e4b7so3193226276.1
        for <linux-perf-users@vger.kernel.org>; Sat, 17 May 2025 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747495786; x=1748100586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E76WBjaIXE7yacVKMjhiwfWfY1MnQgFTPSKDJiMs9fo=;
        b=ioJqMfZO/lEZWIiZKHAovWBH7JdB1eNUMlIgve1y1xKLbRfTdsah/lbaiiAkQksU+e
         4eQpVvM1MawwVEzmAJx2r/f3gbpM6iM4NeYl1YZx592pnsk/Ii6hWGMzuIjYIf8PREcy
         pYyBTw1KhhYsl08f2JXEx+WjRhkZSKbLbIwPvDYfeveMB7xZqHatxJwuHS+o3OhVs9jF
         MNJgpt0nqaJCrfcRdGCaqFapd5INFLkBzyThr/89RTcCfWhQe750GOMjac4mmIWJWHvu
         X1VmSRgVbkoZuKhN/SSy9pIxlrbqZBE1v6G+R5QLvKs1GkBh1ERGg956MXSXDiBb+1NK
         tXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747495786; x=1748100586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E76WBjaIXE7yacVKMjhiwfWfY1MnQgFTPSKDJiMs9fo=;
        b=KbYEpihuQNVcX9+F1qjFjObvKHXy6+GvkXOWWpZQ4oVZm+sDvmy5zGZC9IR/st4wvO
         aqq9Q3VbeSiO/IbdznaYX4epmjVz0CxBAGDvwW4+bP2JC5iS/L4uwwRVCi44nS0heO60
         LT+CNonHWcBt4kDpMhjnyy0fCzx0bUIUNEYC8fOoEwhE6IR9P/fDFnR6NdF1+B3yiPxe
         1U1QqQCah8Fnrv20s2mwI4a41fsIsmYI987DCfb8QsPbV624Mt/sgTvXyDriPv+u+I3V
         EGOAvBKNY1UlRClIpMVU2RGkXaEpbV7ukvbftMMaCKdxRrzKOhW+brke4H00dIzGwicK
         JrLw==
X-Forwarded-Encrypted: i=1; AJvYcCVqa2EqdxhBeevu5MD1TmmbJsitqX+bkfPZURlsoAM+RlTVMROlXeqoQNZGqwh4roRxAzyg5ZGUOF6xuHFrn3F/@vger.kernel.org
X-Gm-Message-State: AOJu0YxQF+UCmlD+RoBxya6DqlJVeC7X/OLPWbvyl27vEfZswhVPk40/
	WLV8QkoXWschkIjsW7LdCvimtL/SoQyo7RwkwSfpdmZGTVoBhtZkzPhas5puN4kUUbHbAYjTa4o
	FFOnNu8PTmmXG8fFv4OvMXmp70EnLOwY=
X-Gm-Gg: ASbGncuprLEwvlsouLGBrtXSOxADDxYlKrMfswmnBr32qtetwLkxNdH0a9/ixr1x6fm
	o2+hm0G6N3WijI2ves9fgdE6TphDYqtQM4GpOZ6i+3mgVGbJ1RUUxwSJMJ/G3IAfhx/L2EbBAme
	hhCqvxOAeV1GCg+anF6MVly7ErB7oXaspPtL3tZ8uLLg==
X-Google-Smtp-Source: AGHT+IEsiu5rV0QV1nk+pfQ+4LNesn+fe3v2t+t3datFGMERtDHCG+MB168xqle6pAo6/riBknRaYq0yRzx2bVGz/ug=
X-Received: by 2002:a05:690c:3390:b0:70a:192d:122 with SMTP id
 00721157ae682-70cab0c30eamr86182857b3.30.1747495785979; Sat, 17 May 2025
 08:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403160411.159238-2-ashelat@redhat.com> <CAH0uvoh8h2NAw3wbBwXAKyAHWS=QehM=pkBD8GOc+f7CcmedyA@mail.gmail.com>
In-Reply-To: <CAH0uvoh8h2NAw3wbBwXAKyAHWS=QehM=pkBD8GOc+f7CcmedyA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sat, 17 May 2025 08:29:34 -0700
X-Gm-Features: AX0GCFsr1353X2e8cV39IrVjQWdEPsa1DyU0MUemO2_PDI_6ESvRrPvy7cj4kRw
Message-ID: <CAH0uvoh7kE==UksrqVEXCdm_oxf0wbEcbwVVm8QxY5TevbJN+Q@mail.gmail.com>
Subject: Re: [PATCH] perf trace: always print return value for syscalls with
 set errpid
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Ping.

Thanks,
Howard
