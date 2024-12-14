Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C441865E3;
	Sat, 14 Dec 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734179646; cv=none; b=S9joy6nJQK3RHhOl0Df7PkDTLo61vrPOkzap3d9M1S75ERMZeZKbBO47gRYR5rADWJbOmVsh3hTN0aLLtoiAsndfatdHtDPUHbdX9NDqCLfuJwxmFTNdBWa4KyQOg+llTZDXedrLI7qzA+NrPm+P6eUyTqyz0bg9/utFyObNHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734179646; c=relaxed/simple;
	bh=kyUbxw0R62bXEYtVb9x9XyfD7gh6y3VBriZ5F9uAB8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAuDnc7xme+6LmQlTQC+u1UaMqz+MHa/AxiIkOHSrCEiFG9kGvhzKuBTxgALDLhuH0tVStODJFvtwOoY19oh23JYepAwPVCIzaPR/T6CLkdeavJprCRbVosdFQxwmY/hi+6dtxmF6z9IYjuf/D3n1QldGIkR5YX6MzBORoYUFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZBQR0Na; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZBQR0Na"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728f1e66418so2256811b3a.2;
        Sat, 14 Dec 2024 04:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734179645; x=1734784445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WUj/cAqo2JcqWWl+TlSeZy8oPEi1XgGyRhrstAtopI=;
        b=UZBQR0NaeD+pY5hkSK2H3AuP3xKZ8NHkgqsQyZfOGk/bLmYliMu3AINmeLzIb81kKp
         roZ8hTOHU06bdjQyjd95auzupe9s1iEK85eO2cKqvi5Qv3h3qB6VWC9zus207/X9Uhmv
         syMt6zdfDoXGvJ7zrPxLZ8epVvAhwsG9DbmpJUiZ0mh1v6fk8c8Yx6e5lZRsoai5b/LB
         Xx3PXfbcr9pK6Od+sDpPfqASBxY4Wo6F7u83RXdFXoAHM5NOqt+PDJkIwj6/UeLQB1Sq
         TwFGjDPOUTqbBbNA0Bte2oLpqSx46h/+WYhl0iBiL+U6kPBc2/k4gNz88zf3T5Jcc+K7
         pfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734179645; x=1734784445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WUj/cAqo2JcqWWl+TlSeZy8oPEi1XgGyRhrstAtopI=;
        b=qXzIRDP152G40Jx28PvkkcKTLUhoPp+k6wdvY13kugOSveLCJ7gXgQImIAVtzoG7bn
         cLOgIpavCYKheXt/P7V11wbVrFTipGWKckmgLQ1PGiceAGOxQOvWtHxoXX+ZPormptrV
         GsZ7N6sNOBlS02fXisz3agAuunc1nU4RFaHa0Ia9iardWgQksO08HgYflrVG599BT/pY
         dquIzIOyzm4tWMSxikEGB1ojaQEmZFEVN/vgtONOhXjdPCl/tTr3TnUQ2FbZEkS41dem
         60vBwsEfpzF8YA3EqV8U+04YID+JG20Jb6lGKnljC4WkeKLovh5P++v/FIUPW661SDEq
         c7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlJaDn3PVIGrxe1eka7H+T3kJfalE3FWF/1q46lwzyNQ6Z4ew2H7J3mtdmlmITPW5q6AGH3fiPkv8ZlBU=@vger.kernel.org, AJvYcCUymDvPZZ2XAjVav0L5ROc5eYa1Sw2c7BHBp81WnB6KqmlYZHAWDaBSly+/YFQuP8gZFDOwoMcZpPBrLXJ4I3v3vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ghn+POgd+PR9EoTaJg88ym3buDO0xfWliautN87kTkAcaPdA
	DadW4dZv+xMdYNYkKcwfTTg1uP4up/vacNoK+Z79E2zNm9CxUaAc
X-Gm-Gg: ASbGncuNS2I4VV0KsBwf9YQ6+sSlWavvLXm96kzqeeiQtGEWJywyiLxdyF5OZ5L/Cob
	o7IUgeGaPQ1k3QBNWBBo5oYGYe4XJmpe8eDPDaN0WvJRBiSzoQGz63aWBsCh11tqTJNrWN3bmPZ
	YV5558JnhQCdfe4QG0mwQoPzp12xEwdpnasmCZHs/gjcxu5S8aCff8Yx43KMpu5Fik/Y97nB+06
	WJ4NAhZBJKcvpJ140zr07cJsNlj+YhNCeOVcpnR/nJ2AkTSj+VnThS/t3nuhzWOVpddjcy++bPW
	aULJRAe6
X-Google-Smtp-Source: AGHT+IHLaroaGzAW4rjLLfj7snS2Vx7G8QK1xWjDY9zbMEviZU/UQzHcrJFEUtBnKBFIF7AIZMRnhA==
X-Received: by 2002:a05:6a20:9f05:b0:1db:e3c7:9974 with SMTP id adf61e73a8af0-1e1dfd34e9fmr9537243637.12.1734179644711;
        Sat, 14 Dec 2024 04:34:04 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5687sm1336931b3a.72.2024.12.14.04.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 04:34:04 -0800 (PST)
Date: Sat, 14 Dec 2024 20:33:59 +0800
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
Subject: Re: [PATCH v1 3/8] tools headers: Update offsetof and container_of
Message-ID: <Z117Nzo/SoExZTSv@visitorckw-System-Product-Name>
References: <20241213210425.526512-1-irogers@google.com>
 <20241213210425.526512-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213210425.526512-4-irogers@google.com>

On Fri, Dec 13, 2024 at 01:04:20PM -0800, Ian Rogers wrote:
> Update to match kernel definitions in `include/linux/stddef.h` and
> `include/linux/container_of.h`.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei
