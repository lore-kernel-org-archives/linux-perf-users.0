Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85AE43ABC;
	Sat, 28 Jun 2025 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751082566; cv=none; b=bGZNx9TP2IBXdwmG/BNP0yj7/BlW+cZ+KBK8QiIH3xMRAK++6Ytiub1TsPJAvAlUweysq00ybs5CFITmhk2tZFP1VF21HAjzXx8hSfZLi98OpKpAE65R1k6Ncseb8f3c/2Xp2Y/rJFLgwVxSmnyCL04JUcHqfgbX1lkXx+XM8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751082566; c=relaxed/simple;
	bh=+VbhhMSXDkkPYcrdZ8nofcFjWGPDsJ1huMMkFEfZsg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/Gzdg+73PuSqeKi9uMBwXlzYus297lj2sTcVO8g3RXgK9M8breg5Yll+8D/zUCXlcj6q6DXlXVAowfpSOGxNGe56e/MsprNHsmE7kXQmprZoBtHQY6VYrXfcdG+DBpyfaOdRcSdKn1ni2pyelBEFXfJ1A0hAqPwwW35TDC2h5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRH7QcPU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRH7QcPU"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so880030a12.0;
        Fri, 27 Jun 2025 20:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751082564; x=1751687364; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+VbhhMSXDkkPYcrdZ8nofcFjWGPDsJ1huMMkFEfZsg4=;
        b=KRH7QcPUg2gAbIg9Yj86/5aN//CYGG5jd6WzN3Hu32+SY+8FNXoZnew9QCKo93L2Fc
         A1S9pbHP99s2lptIciP5TUrO09fEtFmkceVZtV/HDZT2ONPAH5zzdoSNX9qTk9QEBrxO
         nF3rRluZ3grHG0nUzfMiyTbBmysee+y0Tl1JThVALXWwR8siPQavxdPciLuVQQdGZJJS
         Yk4LUAMgcZvhTIhSQZZ8fybhpfq/pJJBKE/qQeVMM1KH04eXjVNLvroEoE0kcZ0lQWrA
         RzT3Y9bLP3F0Wptg1i0Cm1zX7jJP+DADpW4zY8XPvFJXJDR1iFAC/by/RIhBy9T3c6R/
         injw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751082564; x=1751687364;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VbhhMSXDkkPYcrdZ8nofcFjWGPDsJ1huMMkFEfZsg4=;
        b=FZWMj33yPXQAmOuW1kXkNM6cqJmRb8NQzLa/WQTEax5SWnQFaZLqmoosKAKuD/bUE7
         XGzd13fjgRL5A5XpzbVv4+abMBZ3rLR9kBjUVDGyhXFi5mjlqN+F91COt2GBAhZ+7knY
         JGJQcwWNkkVStoxa0I8z33gvFsSqV1TYY/RCcb5w4T1t/A2ZU2C7tV7vvKFzpsPAGNTm
         1Wux8MDeFqRz75dI1XbuoGdrO1EpW5A34iICtZfFdGMvncjoAWaABeXjt30WSwVGhIBb
         i0/YSiQ5DHkM6a1hN+RlGjZ/ocoOaRLuK9WOsxfMK97O7svGamDpeZqz/OMPHmNyZ8EW
         YgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCURIKZ3PoLm+xK5OvRaW/R/ZB+AgZcvZJAdBmauZoVwEWFUoGpiI1sz1Y1rjoM8mYTadrYyGTHNb75Mb0g=@vger.kernel.org, AJvYcCUSlT5bw6LO5DssBtAgGtEjmbiJ1IpFXzgxZDzpHt8wI7NyPhdWI67qDj2FkjKjmICMxNVMwRoEGPlfeuigzkDMvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrfCYe8ldpd2UHKsLE8J5GEZGyxA0N64TUGdq7HPXkao1/sDtP
	70QSjcXT+tU+SDMNPCmgW3R44tzwk9Vqa/P63nfm7PKdDpj6E8zgZi3JQxXLjTIu
X-Gm-Gg: ASbGncu5etlnaI3Hw1NtbmhW2vr/OnJtqm/mcQJP4a4/o2PKDlmjfadmFgU7eEZe6BK
	jSsJw3/I8OJtGpsWxrhDTn6OdUW8ImzkxgXnjm67I8VDWnq4hSao/FpjeYBFU8qzGbHlyPm85mU
	nCIDQGxU9e9ikDXLsSNfAOtYlh89UzJPDGscxI0bRAJiFDgQ7QXLBVLF7cZHSZXc9v1i+d/mZAa
	wIUgG3e0eHXzlg+wtBHNpEpNPvfMxv4opMs9PgI22/ocBSJIzAtGRZNNMp7a0o3cvju1Osv3E5Q
	6VrctQYycIX+Tu3s2QiUevkU+AlbNHGNQmQQbehfEBk=
X-Google-Smtp-Source: AGHT+IF4eoz8bLpfYrgnCrKh3fZUj1la1a6ojNTLqlElVyiS4VJiu00WxhG2AtOtbfkEsf5JqlCWCg==
X-Received: by 2002:a17:902:c950:b0:235:799:eca5 with SMTP id d9443c01a7336-23ac463e850mr102191345ad.44.1751082563829;
        Fri, 27 Jun 2025 20:49:23 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::fd7d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ba060sm29272515ad.197.2025.06.27.20.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 20:49:23 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,  Ian
 Rogers <irogers@google.com>,  Adrian Hunter <adrian.hunter@intel.com>,
  "Liang, Kan" <kan.liang@linux.intel.com>,  James Clark
 <james.clark@linaro.org>,  Charlie Jenkins <charlie@rivosinc.com>,  Ravi
 Bangoria <ravi.bangoria@amd.com>,  "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf build: Specify that shellcheck should use the
 bash dialect.
In-Reply-To: <87a55sles9.fsf@gmail.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
	<f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>
	<aF2Fx-cYy6B69d4S@google.com> <87a55sles9.fsf@gmail.com>
Date: Fri, 27 Jun 2025 20:49:21 -0700
Message-ID: <871pr4le4e.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Oops, I assumed that on a system without shellcheck NO_SHELLCHECK would
> be defined. Let me write another version.
>
> I think the 'command -v' change is best left for a separate patch(s).
> Since it is used in many other places, and maybe others will raise
> objections.

Okay, I sent V4 which makes sure SHELLCHECK is empty when the program
doesn't exist [1]. If it does exist, we then check the version. If it
does exit and is a supported version, we add the options, or else we set
it to empty.

Collin

[1] https://lore.kernel.org/linux-perf-users/63491dbc8439edf2e949d80e264b9d22332fea61.1751082075.git.collin.funk1@gmail.com/T/#u
