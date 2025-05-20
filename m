Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B701DB15F;
	Tue, 20 May 2025 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747712896; cv=none; b=PSCEffWan0RpLCFFC1HMq6ssckXwY0cnd2qcdL0v9heT0LsI83B47uONP3T6foMFOk5prPNyM3bpKDBPngiiSVgVD40GqpP35kffP0z5s+XPWU72oOZMOCbbB4PT0p0m7+e4BL9MNPs7oJpFr5MVyZK7onk93A77ffeeXef07uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747712896; c=relaxed/simple;
	bh=Lp+djizd4Z/CYSeOSr37deLNjfM+PJIH68jSk2+QK7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRh7ByoDCGh3Nk57oMY45uPEe4K+EMfvm4eqmFRSm/7TAWab6BrD/G9iQu0mf+8SM6M7Tn2diVcxkwaC13rzWkEwpafTWDB3codYurRWDzN+h1rlaBAdBAaMEe8nCv95FkS3tyNzxoEr7poLEAUykWPfKCoocsJYSyMzC+VUiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8cMh0Iy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8cMh0Iy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23205d55bf4so21562505ad.2;
        Mon, 19 May 2025 20:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747712894; x=1748317694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QECoVdB3z/ftBgsSiAYe8Vk505pn0CFxH77lWtWEAqc=;
        b=c8cMh0IyxGrYvFdXe3opvEPDN+AEfDOWS0bDfPgeQ54NpTgYnu9yw2m0H1NEGAMh7E
         c3DLedzKVOMqNdTl/3KP/4w2FNO5GvkKHn+xO/l9fKxm93lh3N/RZ0g98NbG1fTAXTiV
         tYTdBx9pTuhNnD2QNTw0hp/0mcPnNG/gI06RTqeB215X+uXbDei+DkoK+48HozMZHIL8
         7xGqkk29SICPnbSEV0fKzNfRUhMQjiPvSnqX/ImhYE7OpYpf4g/PS6ctrtA7H/M9S8uH
         aoYn+34QAlvcEVb6wqX+Vt0XIVbq5rY8gcLQzIldE6O4rubIyti2E6xh3FK9K47zUpcw
         LavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747712894; x=1748317694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QECoVdB3z/ftBgsSiAYe8Vk505pn0CFxH77lWtWEAqc=;
        b=WTvIutnOTpxpiDnc+kALRluTHh2+TPsCVYka4T+0iYC5fqtxdhydBusv4dmzBieOw6
         a/q0riqipfiYgBNAC/WAwXEPD261Yl12FJ4+jJigoChXA/qg4KyioFFiJ/Rbrjp15x1S
         dTsFCQZLgRpXws3W/S9vQrGU0KGL6QHx8FUMj5K7GJEyAyZT6XaLZbmkhClIvnU8Rjrq
         t8oKMFyeElQbMcnscC/IpgIxUtCuN1fv6RbGj4i+P/OnSJz8pjgECstSo9b1nDKNF3kt
         NznQEEQnr42PzKY37BFWSmHDtHsno8pke9fMuZYyvKfaMxkPXw1NsbQgfdkD5FTzjW2j
         bHNA==
X-Forwarded-Encrypted: i=1; AJvYcCUo2UPoGAjHsdDFRLkvmEWASURy5nlcbjlBRbobbSeqV/ZxQDWZ4no0nfyhXoD5Oqojy4+WBOsTsC5wMQw/QGLbAg==@vger.kernel.org, AJvYcCXWkmC1acXGd4r+qbNY9ixwuPPJu3Cv2fnAfzwxnt3d3U2fasCPlWi4Hj3Aj9j/D1+mgGgDbBu35Rmq5hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtQHdzeWT0J45O3SeRxB6tNmNl9Wa5cT8dzTMkmnkPjB+nKKp
	wAnsFgX46Z74SBv55ciXBJunbB8hhCKLCx+okDo20GSw9xIJCNCRU7BP
X-Gm-Gg: ASbGncvkizUUiuXMVu4O8Z2ms79WJrzoemMY9Hfw7ijrXuE2KlsckkfxDd5M1V3/3Ay
	TSQTrKKj6Z0CV3h+qTzrehsPrTMjvWsPf92gwPofNhHTy1KfZgUveWd6VWJkAOcR6RSIah6ifyp
	Rf+nuehDXx82gsPjFk4YNNzKO5ySpg5NmgpNKEonEZHMT95CiF6HKbyry/f+SzJaFeXyZlDXfwq
	En55rfjV+E9x2bDcLPWSiCXyAtCV1p4/CE5/WPEB2/rGnNe9mlD7xhyNGIjDLwWrP99jTgMEuMl
	QMTc/PtHlwhPOHgLyY3YxKuK+CL5uZVHwM2m9ffzfkXgju0zgu4S+WIgFLpvfA==
X-Google-Smtp-Source: AGHT+IGZ4W4X6eCfr+cSRAd9w6mjBe5iHSpecvTvRl0uxTw0///FfG6d8lfPRUpqK4Q4WIeIBFUfQQ==
X-Received: by 2002:a17:902:e84b:b0:232:59b:58fe with SMTP id d9443c01a7336-232059b5b4dmr146516715ad.1.1747712893826;
        Mon, 19 May 2025 20:48:13 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac94a0sm67701655ad.2.2025.05.19.20.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 20:48:13 -0700 (PDT)
Date: Mon, 19 May 2025 23:48:11 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	I Hsin Cheng <richard120310@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peng Jiang <jiang.peng9@zte.com.cn>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH FYI 0/7] Updating some kernel headers with the kernel
 sources
Message-ID: <aCv7e4Jr0s6ViN1I@yury>
References: <20250519214126.1652491-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519214126.1652491-1-acme@kernel.org>

On Mon, May 19, 2025 at 06:41:19PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Just FYI,
> 
> 	Updating some kernel headers with the kernel sources.
> 
> - Arnaldo

For patches 5, 6 and 7:
Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

Would you like me to take those in bitmap-for-next?

Thanks,
Yury
