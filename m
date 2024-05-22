Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB9A3F
	for <linux-perf-users@vger.kernel.org>; Wed, 22 May 2024 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407445; cv=none; b=SBtiRd3HzVwbI1PKpEuh1BB+PX5jbgY+KNojuErdmMPBr1QIMUzIqO4ND8VKW/8t5EarVDNV1CdYJg/cAyvds+OF27+3Aqc/qUams6Z7kaoLJEt+ZkfYicwBt/CXUEM7KuyEyAOHyO/rKDOOhoTSeZP0Jq/c2hDVLx6jZjOXUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407445; c=relaxed/simple;
	bh=41QZRP2M6ZrNrPrgiuljuIVenZO0ltyNJsZJOOtTM38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW4ixRw06hMHVthISJ5nf4XvvS2rw8IzL5GWuCKCV8Ji8b4RvUI2GPXo18ythMiHKDnGyWitKEybnsNUzb7WX6Cn5xZFIXLZcUKPNcclxdMp9qIGqF1ch+EXhagG9VVdhEWvFVCOjUD/wEOTdRZTbAGTD9al1MeQHUAiEwyleBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/fvyQmv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/fvyQmv"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f45104ef0so6840592e87.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 May 2024 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716407442; x=1717012242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDQjgWpXJk9D29dvxyUKhngTYIc5cNvHghe8rMGJxk0=;
        b=S/fvyQmvcvXguhQoJlYospg6XrkZAvIKsbk0DnkBKejwmfPWOLlDonGxO3q+7YdlDn
         5f05Ul76iEe7Z2alN3kcBSXRfSYTUPVKre/sCK1AB0PR/NTxPh1KvuBqAnEwsmk6mZvK
         9BJiAb6D+6zYIv9QHDpZK8viBc68+0kDQKHw33hFJZ/U+WdS07UH1zggnr5Lsf1W9JG3
         WUw0bfX4F501wdJuWnTPdtTGwvxWzbf/orowSxDWXb2C30P2n+GWiW4ufxWL4jGt3med
         GiC4gtzqdfJ7T3E/8JqTw+VHVtRS/Hasxmb5dZb2joFPCn4jOvZAj6RTTW3tE3xWBBv0
         uh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716407442; x=1717012242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDQjgWpXJk9D29dvxyUKhngTYIc5cNvHghe8rMGJxk0=;
        b=UOlZEheTRrKvHBrwSvm8dkVYy7aE69/hPUWlpeIMoGEqqvsnJRlmQMBfNIiHR00X0F
         bkdlyGAHSJBO4wtsPWMneA3WzhppbQLsVY7nrbxAikG8dIbUpGsjJWRgKqI6XNxOCSFc
         i1QbbsqhYxG0qpHdpkxa44I9vo12BtSxu23CnGmrqVNYkvNH5MybhYq/h7Dx5XmDq9xU
         x+ExXdL7NT4BtH3MhWo6KUBxn8SKc0V2UHbPhBb9KOAUO5TwK/A7xX/33kEDmY+mSHZu
         LojgniwDO8AU6qHsAg2jM32Ozf6MPgbnWTMj69SepAnl7Q+O/rOWd1oQMeilOV20H7Mn
         Gjgw==
X-Forwarded-Encrypted: i=1; AJvYcCVRi5T+fhZSZoO79MeLum2UlrYHR+R0mVkdm7Mvm3mzpIkZeq/21iOLy0ltIYG5RydV2x22EyXwXck38bhU1etNAMhFu/90FCKfSYCTJn64Xw==
X-Gm-Message-State: AOJu0Yw0nxfpjGFKDk3d2xKidlzsq/lUkdu1h0UC3mPR1RTHGxq0joNd
	7JoV3Z1t6016TG1z2MPQr9OZv6cu5yGe5NnhJJkibxfOS15Kyv43OnDD+2f2rA==
X-Google-Smtp-Source: AGHT+IGXCSF2B3Drn46KcGjpfKvi7xXveSGP2JEX+K1phDMqODF8OQ0EYepBQOcDfFeAD/VSZom6Nw==
X-Received: by 2002:ac2:5506:0:b0:51b:6f06:92f2 with SMTP id 2adb3069b0e04-526bf35cd13mr1623624e87.33.1716407440655;
        Wed, 22 May 2024 12:50:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:abd9:eac1:986d:5b77])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-526f36a5cedsm234196e87.132.2024.05.22.12.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 12:50:40 -0700 (PDT)
Date: Wed, 22 May 2024 21:50:35 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH v4 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zk5Mi7SliDOd8uO4@google.com>
References: <20240520083048.322863-1-sesse@google.com>
 <CAM9d7cgBZVfur8S3QC2woUA2C6O3Dme0YHP8PbFcwc_o0k-dWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgBZVfur8S3QC2woUA2C6O3Dme0YHP8PbFcwc_o0k-dWg@mail.gmail.com>

On Wed, May 22, 2024 at 10:27:06AM -0700, Namhyung Kim wrote:
> I think it should support other DWARF use cases like
> unwinding and type info?

I don't actually know. I had a look, but could really only find
documentation for _writing_ DWARF info. However, I've hardly used LLVM
before, so it's entirely possible that I missed something.

> I remember bfd objdump is sometimes faster than llvm-objdump
> especially when no line numbers are requested IIRC.

Hm, I've never seen that. But it's impossible to say for sure
that no such case exists, of course.

> Anyway, nice work.  Maybe we can implement other use cases
> using LLVM and reduce the dependencies.

It's possible to remove the libbfd dependency entirely if that's a goal,
at least, but I don't know what the current thinking is. I'll be happy
to take a stab at it (I guess it's possible to test the PE support with
WINE fairly easily?).

I found out that if compiling with an older compiler, LLVM changes to
llvm::Optional and doesn't have .value_or(), so I need to fix that
(the patch is trivial, but it means I need to post a v5, I guess).
Is there anything else I need to do after that to get this merged?

/* Steinar */
