Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209161B14F4;
	Mon,  9 Sep 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874386; cv=none; b=mgIVSmDLZ4vGKnLOXfUtrB5dBrwD/WUFo90yidq8kTVl4M2wlZVCWM2qNjIlJvzAsx/hlNuveRTkKJi5MspMLwKe02DkjHsjEYhPAgSBx1DJy/WTFi1PkH0usCfAaVFpPU8KGnHsCorMw4Td8VYxLXF9g+ONXjp8sXlpnF23bfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874386; c=relaxed/simple;
	bh=JCbUFs/C1wIvZf/qvlumicdX/e9VSeNAWv9daqXnCJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6Z7gXc7qrAfUkb5eIfsK39zR9ITLDA2MuKdblkIkXDAEdvRrPWnpndf7oodOJizIOTDn62xBT1EHIx7gbj3Osf3Of67JqoXSDABxTQ3aw3Z26Z/5Z1af53Vx8bFnCxhZKKhv+P1FW+YrYGShXWkLc3UE43UqtmusaCujONw+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inndoNAe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inndoNAe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso23341115e9.1;
        Mon, 09 Sep 2024 02:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725874382; x=1726479182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqzSkCl+TxKf00PG2mzigkfVsef9Z51p7zVpAFNA5uE=;
        b=inndoNAeNKLYwTHO45HIwi6tOqeNGj1WxP0Sn3yvC3kuA9gTEv9TyJ4cxKjKYM5ioj
         YU55dvro2gzGkVE8LchsIgxxyNPyi7gCsyUMuUuoLfdfj1uAjtwAwzQ4Kb6jKKD+pxts
         d4zQjQ6uR/zfOYMgkoAtyNrhOoNbtVWULuxwOaZXjuZQcSJmHlp/295PtGznp5MaRJqb
         7qy6uk4ZcUtgRTTZ/Rm7tLt/jnLsiHc5sibdLvbiCEjRxvDDa632oFkdoytXoBLUlyOg
         Xro7wvWdpah6otjZmTkcjLZOKELr6YOog6h9PyB1mn6SM5QUvdFOyEZEaRDFnQf/Rqwt
         0Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874382; x=1726479182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqzSkCl+TxKf00PG2mzigkfVsef9Z51p7zVpAFNA5uE=;
        b=avg770htTxoLMqiEIRr3g0YiOFDjKoWXJHAWNXK6KW16FaToQMDf7Hy1j0LKrhef6B
         grsTpoCGIIjITJYy2SMMFwqfVyGRBS1F65H6CXYSO3MyzXVdWf0qdn5l+udB0ORIbRrF
         SyAtDTr83u8CiGZgbYmJdP8xkRhZDBdEENPWtvzXii1TrS3M7X6sFs4uRhb/lpU8q63w
         oLf1/K0gys1s7/AlN9t6ePzWhE+OyZ5b+oHoXEKPeX2uWR1mRVo39uHzIQjzKG7nmoVj
         ALtsBBDKoC9MFKlP9XYCYsUL8G88QcJJxxQRv4aFd8H/uahhjzujWWGyfjTTgDs8mTm+
         gl7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfdOpY8FGB4QY8NxHdljgo2t6yPyONDmetODl2EgEZMInPsUvkj06MX6dpSVpXdv6VCHfijH+Et3PgPRs=@vger.kernel.org, AJvYcCWH+jXRDPMqEOVgDMQbkg3yZhRV2CdFaycKKUKrmEhzikRTuQVyZRn7zEmOOuBYkBD+hO9hYLrNxVYRlDcoEocEog==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyqoKumtSH73k/oIW2QZ6SHe9hYSeJGA53sks83q86sFdpeEVS
	VIXtfapCtqaMzW2+PiVSSmKVmyf6gUeyEn+aaG8dg+s7tU9Sj2E8
X-Google-Smtp-Source: AGHT+IFjK/9zKFg4oNkxNn4k1rsfRpW9LMKyHVy1EkQ6S94u2Cbwg321KweRVUDGxDt3KJYIpA4Mpw==
X-Received: by 2002:a05:600c:4f52:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-42c9f498db4mr60731325e9.4.1725874381404;
        Mon, 09 Sep 2024 02:33:01 -0700 (PDT)
Received: from gmail.com (1F2EF525.nat.pool.telekom.hu. [31.46.245.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeaba04csm70960915e9.0.2024.09.09.02.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:33:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 9 Sep 2024 11:32:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, gautham.shenoy@amd.com,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Message-ID: <Zt7Ayphs3F5FDCQh@gmail.com>
References: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
 <90028792-19b0-4371-a8b4-0a37612b4c9b@linux.intel.com>
 <ZtmC8hhpUvQTXFDn@gmail.com>
 <a310b7a1-b11d-4efa-8352-c57875047ac3@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a310b7a1-b11d-4efa-8352-c57875047ac3@amd.com>


* Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> wrote:

> >>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> >>
> >> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Note that I just merged the older v2 version into perf/urgent
> 
> I'm not able to find the v2 version in perf/urgent right now, tip-bot had given the below link before
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514.
> Have we changed our decision about keeping the v2 for backporting and "revert v2 + apply v4" post the PMU scope patchset?

Yeah, so initially I thought that this comment of yours applied to -v2 as 
well:

 https://lore.kernel.org/all/b34e30bc-a003-4529-bcfe-8189ca7ddc5b@amd.com

... but in hindsight, it's -v3 specific, right?

So I've restored -v2 and it should go to Linus this week if all goes well.

Thanks,

	Ingo
