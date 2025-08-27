Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321A1D5CD9;
	Wed, 27 Aug 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258150; cv=none; b=CZzfcIO2Exd5HzD9R+Gc80hZg78AQPEo63XHvjw4koaHFz8+wyqwTEV2Jm8aJpnNizaLklYPRJL84z0PeQuk4koAPDAPLmU4Nob4VsCfB+HtH6lXV3l2bM8TBCSpIdEVRDIQnhze7s8IlAwE6spWDVTrXgun2DbDfFQXBrNbYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258150; c=relaxed/simple;
	bh=aEZsdHKctgEmw2cdsNlOfSwu8BbltbTEYEj+KUDSzXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdfgOuD/YUzcLzQTdsbRMY46ugbLCZq9SQ4dDrwojxePLFb4eAh6VOMouCDdOGqk26jv0633Zdr1BamGRA5xo6HtfVu8IESxOt+Y+N8X3RHwuikB0HMlqAqvvwaUh8eEtPsC+5st30H4iW2qQ4zM0MpC8V3nSbZB25nCacheuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N902gQjV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N902gQjV"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49d98691faso2236768a12.1;
        Tue, 26 Aug 2025 18:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756258149; x=1756862949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=slICnE+v33GsIBXPz8FikU+2GjnEm7QwJXAIDftMKn8=;
        b=N902gQjV3jWk66MjPOzNKO7e4TdsNCs3paaY7uKdYn39lvMBfCEFi0Jbf325R/JABL
         SAgx/Aa71R3bRf5adq/ZnSJqnlAKXd3ZejDK+Eb4u9hUp+DtLgbLRsHKx26G29UCoM75
         cmDsXoeZqn2gING1ENGwddOkCYF/G1m0Z/GKxl/VC/hJZO/kBdsUtZ1am9T5nPR7PbGS
         dg1SnYHRnkD1YMhq1Bvo7SpgOqzDKX+OwIE0H7XBzCgBMk66hgJfhfEd9GJX2ixxhkEm
         CVbvfke0XM8bii9ETxfC6wmcdgYkIQzFXfO4k34O2ZSOGOoVkijk+WFF56nYSqDv4opu
         dnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756258149; x=1756862949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slICnE+v33GsIBXPz8FikU+2GjnEm7QwJXAIDftMKn8=;
        b=HB4okxdk102/2kBDx0BUy7+MFlAEzHDZd2TEwbUEMtCeolN8rWByXSn7RFfuHvaT/H
         9HgjpHauR6g84lI9jZEmQugg/5DQwLP7ZUbnzuhAI/XPnM2YaOqpNa5vNR4nnUqlMjCZ
         EFsQFNcwIZNV1P/X9g/bqkm+am2pjVMS4KjAk/QqVszjn61wXPiUMl1TbGVt4NEIV4GQ
         7pr3nY7oYqtMGlnKoI99hE4UumZuQRVEKY50csWd4Y4yFmvMXyGpcHNfu+YvMvNFsOzJ
         TZW9S45thM5IZV1mxpxOw519x8D20ntVz5gzONsRK7w9HDaY4h90reJ8qJ4ZiRQxnTce
         O34Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3uWm+msNDCF2VIh9tTNwnQaODvf/35r4FVtr6ha0bGMytQacIp2GZrFZqEwfuPsZlQwwqyR1lEFU+BOJMtYsqqw==@vger.kernel.org, AJvYcCW2AFXev46I1ClLxrWWecjcioTAY98ErFzVwVRB4mI9WQfNqFEXQG4p6+XSshBjBuZpd1qKzuN5btUo0Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsGti7WYpnJRf7IOgQRg6ba8P3tXVWF6lehoaTUlzPoqyEn1n
	oZP6J+uRn/x0MuGbjyM+SelAXMyKTA2qF/f3HXhj1BRpVKSiKHmAI5nu
X-Gm-Gg: ASbGnct/nOF6NboRCKwT+HWGUiMxZnQNmbNRD3VGOM96QCMyNPqablPgJIpbCd7KsKt
	xl1w/WhUrL0UdmaCVFIX9fylBl2TJ2IY8n0CbH6GQVhb43YnXCrsPtM8qwsGg/JVNpSGdUHO7lI
	KBJ4CVRJcQpnrZKvLWavFKs+n/gzry+1YoOEsWhbYLQHzrUI714MubACaYahPmEYObXLInIS3ZQ
	UZkbulXD3PipV+nJrqVXtOrGo81jpf0xr7+h/CVge62uQWPlrgxIQoMKSx29XhtPiZZZoQZYWcn
	oYsNIsDJnmSt704zVmOgI6N3Or36s90VJO1dk9cUDyBofyQB/7eknkTG/85ASI1G1d991+fYVJk
	4I9wXW5XLdQzC9Zq5tZBdRA==
X-Google-Smtp-Source: AGHT+IGE5GtWtmXV3TppDNuqIwNbKfhuc5Hm5JcE59wnGpdV0vLMOGvQYToBz1oP6WKdgfkPbGDbNw==
X-Received: by 2002:a17:903:f85:b0:244:6a96:6912 with SMTP id d9443c01a7336-2462ee7b50bmr227931895ad.20.1756258148760;
        Tue, 26 Aug 2025 18:29:08 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24873ceb334sm26287875ad.51.2025.08.26.18.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:29:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:29:06 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 02/11] tools headers: Sync linux/bits.h with the kernel
 source
Message-ID: <aK5fYlox4cbXaSVm@yury>
References: <20250825215904.2594216-1-namhyung@kernel.org>
 <20250825215904.2594216-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825215904.2594216-3-namhyung@kernel.org>

On Mon, Aug 25, 2025 at 02:58:54PM -0700, Namhyung Kim wrote:
> To pick up the changes in this cset:
> 
>   104ea1c84b91c9f4 bits: unify the non-asm GENMASK*()
>   6d4471252ccc1722 bits: split the definition of the asm and non-asm GENMASK*()
> 
> This addresses these perf build warnings:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/linux/bits.h include/linux/bits.h
> 
> Please see tools/include/uapi/README for further details.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
