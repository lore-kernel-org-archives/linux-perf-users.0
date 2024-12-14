Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F901865E3;
	Sat, 14 Dec 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734179607; cv=none; b=cpz4CcjzhxeY66WtdUOLcFl9nwlydzqD4xNwbKr2k5Uqu3eS3d7A4ZXG7XCoc6CLHFHt91UqE0tos9ky20WJaCBQoSPWesU0OATppBLL3mM3LUl2v2Ko9H7etH1wl8oqYQartgVa3RgpyueNu/vwUwPlkFVC+NcmniUcYYLCRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734179607; c=relaxed/simple;
	bh=NLYX8UxrPLBGaNdZgQFh+dURnCHG3hkTyp8gPQXKQ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0wAyJkhizAHctNaUUV6xii39UwNUwKn6t4pUPrGMS+7XN1DYcstF+TD0HY/kVx7LLA9LlPNo7WOuVYAM7zJsnjblL+CtRhBoKcBkFq5KIrg1MxjQ+1gP0Kt1vDa97M7iYTqMPWDDQTwIPnm0PDCPci9pMB58nb44eJ3FFWSnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8kB9MSr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8kB9MSr"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2005311a91.0;
        Sat, 14 Dec 2024 04:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734179606; x=1734784406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3e3IlXJXuwVGKGf/bNlyWXfPz2EvmMLeKdxB4qkcvs=;
        b=H8kB9MSrmhf+6dD8sOhwjdSAVMKm+NlSm9e6H1ImGD2B2rpl8lQBM4BsxWwAmwRuw3
         HhT4me19Jo9ipIejilb7Kr7D1FNQTb8+20sWKWxlCUFia0feNBAed+RE3+Ea+LDBI2ff
         0Ii9Zc8/5CESLAaS9iOL12PzPM78sQFT3tYPUguvOHgKTCG07IdkgLJSWtvj2W0YcwRj
         UHP/vcV5jx/mO59nR9tNuRJjY1SToSTeKPOgtlRzyGD3BBnq7S2/u6/WXZZXKITC1Oke
         DUZGo1goZSk0pYLHOsF+BQtwnZbqKD6b6ghIx0Gk7hrwmiFf9iDOq10pQMkCsQxjw+U5
         YADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734179606; x=1734784406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3e3IlXJXuwVGKGf/bNlyWXfPz2EvmMLeKdxB4qkcvs=;
        b=cwMtRu+09L+6uoZy/Rn5i4dCmfUMx5TWETF+HZCx3P/17EevpvlSUqY7eoo5SXvS3u
         qwFAh4Q1CnyA1S8zikYoiK6gy0YGsWL5amQokfCBLDCwyq0ms9jwUwAl16R91x3hRyEA
         rwce0OvlJOtFHOPXdzdbS9S1OYaCJpCfTPwPNmJiOb+aPaujquajcZOvWwKSpoCCtT2r
         FwqPtx5N9JF1AP3bkLvn4r+ZLohN4/G/5NecFyIdVr27J3xIvNqoLOcr7S8huHM3EBUU
         SetCKjjTH2C9/JfKZz98Bchhhsab41XSrKdGF+zwsNoCG5BpZNhvtRE4sklCYH46Xazv
         jaDw==
X-Forwarded-Encrypted: i=1; AJvYcCUXicMrDC1iGqw+CanmEWoar+Dl0gZRcK9b0TvFxZAybrFcRLyoMBHvYnfBOQm97iwM+azPvIKooXvas8s=@vger.kernel.org, AJvYcCVILDVAiir4uD6hSLospWtKZZd2sP3CQquzQ+B8WiuMWmFc6rHBrCw51uHFWWtKx8W9LoEgS/XZZK3qJJitCFnubw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8rKdIJIo0lItoUK9HIBxBjwNoY6q/K18xGvKgh+rmpc1i9DL
	f40PQ1vzfl3kyxcyjmFhroj8PMVMMHgncAbt+XJT7nV65F6Jj7gQ
X-Gm-Gg: ASbGncto55ArZTnKHF6U2Sck7IiGFXf+mT5dvvZTnOOqDO3cY/K36zqBYAdRnvoEJvv
	si3M1lw57VTWunMrF0/YhYNjrtoHhUYorB7qxtU3B/MnLyhhPoU0iItlIIMA65LvWpUxRjTNoUC
	Q2WX8OCdPpmXAC1WSdSCqXECeJAtXxLJ+wGZUhuC15vIUvIATsfSkc102kO9BFCMslgNjBm4yyy
	+3PUhBHxStTOGBq45b2SvLtYKSrMtAwASZ4bODOL/BgX0LZCWOKQCGwkVG216S7ZbaBs/s+cf3N
	48Mjfcac
X-Google-Smtp-Source: AGHT+IGz/lKwrwSoZh+KWxQyhGgve198yVy6xpMvQFVVOJEOuD4ov6dTXPK7zHqT3DuBdN822FsKWw==
X-Received: by 2002:a17:90b:4c05:b0:2ee:a76a:820 with SMTP id 98e67ed59e1d1-2f28fd66aacmr8413787a91.18.1734179605749;
        Sat, 14 Dec 2024 04:33:25 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc2fcdsm4742596a91.43.2024.12.14.04.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 04:33:24 -0800 (PST)
Date: Sat, 14 Dec 2024 20:33:19 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/8] perf disasm: Avoid undefined behavior in
 incrementing NULL
Message-ID: <Z117D0rj6waa/cNs@visitorckw-System-Product-Name>
References: <20241213210425.526512-1-irogers@google.com>
 <20241213210425.526512-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213210425.526512-2-irogers@google.com>

On Fri, Dec 13, 2024 at 01:04:18PM -0800, Ian Rogers wrote:
> Incrementing NULL is undefined behavior and triggers ubsan during the
> perf annotate test. Split a compound statement over two lines to avoid
> this.
> 
> Fixes: 98f69a573c66 ("perf annotate: Split out util/disasm.c")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei
