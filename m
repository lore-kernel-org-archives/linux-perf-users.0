Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDC318EF4
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094416; cv=none; b=Yy9JTrvggEo1V18Zyad6FVUY99rX3Kc01wC4JyoCvw+MccfCRZAzvUUJPIJlgJal3FqXU95wLOQM/4JSXC9PSeYI83myCUp5aJY3xWQu2hY7iqQ2mLg0YJrfQfuAAH0r+J/Uy4WlkfowhhspwmpihgRQl5jCSfOCdyqARqtyahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094416; c=relaxed/simple;
	bh=iX4hzBFj2m2KZiJVUrG8vp2JMXC1uhBlllLkPM8W0L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqckXQuCiMOJVQTbylQ1eKoO3n+yyOpwf23vqLi1Sy8Imup3uh6SWVbzqaoToZd6HNVFTUXYlZhRGo7+/PxR+2ewoZqjwXd/Vz+PKZApxKPDJiG4itYMOtMpOGKk2P8hlfp0BnSCzxNaqVmgOALMaeT4CYx/CyIHA4jNE59I/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPCS6XPj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPCS6XPj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ba840146so44515325e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776094414; x=1776699214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ShgF/BpsS7cAVnwA77xlwKbX+t0sp7V8xBcXlbEXIY=;
        b=dPCS6XPjbAcd5lFxQIloBbLEIOj1qAEAy0Z1o1/7E2bSZBjOgmuZ9LWIqx8XtZJZY6
         5E5vQeDiEHpmcTuRQZjvOSmFhzBJ2r/mpanb7foJJh4yQfmNDU107a/dT5eNTFD6Q87v
         EHgYQVZXzoJ5Wwj0ZfVZScxkNgnT1+TMHQzqAC4zKc1QzexLFAexvcE6qr5QPi6eV9lm
         qTfH0mc05A4ereysiVK+ek0S63hWdmJcJk3mLqX5lOqmOAJtrumPiknB41As6TypFLri
         TFPmkObiZWzj6dmJbNt435FNpsl1n5fegAbkmdyLuKsxSidMajs2UtAGRloLMTCHSc3x
         HyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094414; x=1776699214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ShgF/BpsS7cAVnwA77xlwKbX+t0sp7V8xBcXlbEXIY=;
        b=aUpQHJMNMG4kLNbWwcqS50KH/zrLWseqB+W5+4a1sUZaeqm5j6bQiCIWIQOvqdcexX
         /Tm6Fpz0Y1I2wYIpPY2baZEO2o7CWbJTanndAuqKaPp3IcTpW11xIhlst2/Si1QVxixC
         NOC98oNna2/e30/kCgUYIUu7TKuJ2ocSHBWKFjwLWJiv4XMB9Fr0+EiT3EE+0VJf87k3
         A16WLqv4yFcGz/k8G3x+QzruuG0OKYkVctCqxflu4keE0jUmWFKDP555S6a7BqFL7oM1
         GfMJKOnB7ZJiv84qsuxlwxn46tgoC6H/1zGRf2UQ+/769MwZVl5XNldHczK66ccZiY+p
         tloQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SNCiV68VK9gVdHTGc7JeI2FH+17Tc/V1yWJpezlmlnhCG/w3B1EWtLqmmAoau5bzEK6OcaStT1iaT9sXYLMsY@vger.kernel.org
X-Gm-Message-State: AOJu0YxVODjz/ceFKTNkbqazo/bIqL5hgnVSWIaLHNY++ErsSeEWnj4t
	shrhaH1kEXvAF55FHTQovBwuoN8bvKXRK0ec5ywRSCjeJ9hS+t3qbKEo
X-Gm-Gg: AeBDietSBV21qxhkGvuyf1Gc7o2jamt3+ZbEZbXjjFenRUFZ3gjSqTtEuzVaPIETuj9
	vmRNe19jqEUi3s7L84BMIQtlpgco23T4EV2BwJeA2wtIZS8dkqnY29wtE47MSwmn2FhtuNnLIsx
	8Y9OKKEKwi1kt4HZJ7bPySJIluYVHXqgMFBjCt4IIiWqG72VQfy6xyJCGdNs0wH4ly7tfXdcm48
	yAeUpLsOQ4EaB/audGbzo6pBfmBkfwV/Ppys3J90LoK+F8P+5wICcci5n62rv8vqeMEiRxwYqGg
	QpiWBmPVEkzG5R+OmNPkhWcXLvIsazpGEtFlUXdw9DajBtCpzQ3IMhl1L9h28qMz4m6Ka5EnQ3w
	zScDi6otkaFDWN8vTF7vuZR9yqkXwhdv6cZuVbXsQtwGNxvDD3LY1+PlbOMatpcoTUbLEwd3CwE
	Z6KI5KdJTrHYLS3K5RK2MUF/KDH1CNHzNdZhiWgQZtiLE9QXfcr90pS4nw2Z75o8fJw9TRlEc=
X-Received: by 2002:a05:600c:314b:b0:488:b241:2c5f with SMTP id 5b1f17b1804b1-488d687c076mr159606435e9.26.1776094413364;
        Mon, 13 Apr 2026 08:33:33 -0700 (PDT)
Received: from f (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d684406bsm94248555e9.24.2026.04.13.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:33:31 -0700 (PDT)
Date: Mon, 13 Apr 2026 17:33:21 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Huang Shijie <huangsj@hygon.cn>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, muchun.song@linux.dev, 
	osalvador@suse.de, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-parisc@vger.kernel.org, nvdimm@lists.linux.dev, 
	zhongyuan@hygon.cn, fangbaoshun@hygon.cn, yingzhiwei@hygon.cn
Subject: Re: [PATCH 0/3] mm: split the file's i_mmap tree for NUMA
Message-ID: <76pfiwabdgsej6q2yxfh3efuqvsyg7mt7rvl5itzzjyhdrto5r@53viaxsackzv>
References: <20260413062042.804-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413062042.804-1-huangsj@hygon.cn>

On Mon, Apr 13, 2026 at 02:20:39PM +0800, Huang Shijie wrote:
>   In NUMA, there are maybe many NUMA nodes and many CPUs.
> For example, a Hygon's server has 12 NUMA nodes, and 384 CPUs.
> In the UnixBench tests, there is a test "execl" which tests
> the execve system call.
> 
>   When we test our server with "./Run -c 384 execl",
> the test result is not good enough. The i_mmap locks contended heavily on
> "libc.so" and "ld.so". For example, the i_mmap tree for "libc.so" can have 
> over 6000 VMAs, all the VMAs can be in different NUMA mode.
> The insert/remove operations do not run quickly enough.
> 
> patch 1 & patch 2 are try to hide the direct access of i_mmap.
> patch 3 splits the i_mmap into sibling trees, and we can get better 
> performance with this patch set:
>     we can get 77% performance improvement(10 times average)
> 

To my reading you kept the lock as-is and only distributed the protected
state.

While I don't doubt the improvement, I'm confident should you take a
look at the profile you are going to find this still does not scale with
rwsem being one of the problems (there are other global locks, some of
which have experimental patches for).

Apart from that this does nothing to help high core systems which are
all one node, which imo puts another question mark on this specific
proposal.

Of course one may question whether a RB tree is the right choice here,
it may be the lock-protected cost can go way down with merely a better
data structure.

Regardless of that, for actual scalability, there will be no way around
decentralazing locking around this and partitioning per some core count
(not just by numa awareness).

Decentralizing locking is definitely possible, but I have not looked
into specifics of how problematic it is. Best case scenario it will
merely with separate locks. Worst case scenario something needs a fully
stabilized state for traversal, in that case another rw lock can be
slapped around this, creating locking order read lock -> per-subset
write lock -- this will suffer scalability due to the read locking, but
it will still scale drastically better as apart from that there will be
no serialization. In this setting the problematic consumer will write
lock the new thing to stabilize the state.

So my non-maintainer opinion is that the patchset is not worth it as it
fails to address anything for significantly more common and already
affected setups.

Have you looked into splitting the lock?
