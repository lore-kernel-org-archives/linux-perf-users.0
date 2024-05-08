Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277B35F18
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188300; cv=none; b=sCGUqR89uyGN3I27Sf5lp0EUjqZy/62qxN/B/ibxG11eSjVB2WO+Qp85jsEVltoxTlh6kLkrpp0lm+0XhIvt9WKszFs00AB5zfoLQc4MX711PeFbW6cYsTkfVpDH/S/wDIBVAFVy5J08OMckZ0swuOAILTU50JkLJGhF9TROwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188300; c=relaxed/simple;
	bh=3H2Ex21607oQUraLy4a6ZebeomrW6qImqDFNkYN7KH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdW/B/ljd1F8YmV1XAVcCfguoE7zoTU9yZR5TRUsqMyJOg+ETq/+qxQ6PeA1wJ3570m0Q/nHBjiCM8noODBhPTQowV6BgqKlsjTmYr/cZ5gAyPbPE8Tgw61V2XVuTodJmR459TpPQIYyhCuvHLuruVreeNBJrAHdSonb3xNlfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e/7av/64; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e/7av/64"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f489e64eb3so18473b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715188297; x=1715793097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tSmrj41Qt+Se2fdGi7WeozvVj6AfH//AS3pb2zkquGg=;
        b=e/7av/64Dcgf3OMhlc/3aG68Cv9i0FKAXx1yap6cSbdW0nsJbcNd95Yo1lRWM4CXEO
         StJJA023SDun4hdxa5p+ZL91TWCTjhJqbT/I8537Y89y8wwXzIEuISflNf2v2IqVxAlb
         rwDXFcNsSy0ds4FxqMQiDgXwqp7u78CH/UbW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188297; x=1715793097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSmrj41Qt+Se2fdGi7WeozvVj6AfH//AS3pb2zkquGg=;
        b=hBsugWxM2LT8Vg8P6nxG5PG154JEH2qYyxNCH3+3AbjkqPtd7fFmraAzYrTyWZzOA4
         GEezxgdhSagUB2yVFosqR8eQ+HdHBc9SQnrgmVUoiUgBK8Abd1h/hwmFgih2/BTbpZye
         Qr9tTvg1v4DFT1MwzBgNa3AjeAj0WgDGYBjQp4cPY6Kj9d2DIGewtC9GA3rSN2GII4K3
         HTcRYm89Tyj8aPU8tssj092P94Lmys1tmKTp3mP87LAvK4d1ze27cf7ORZBtyhL95qnz
         vIPCIim7rniF1BAVXsQ3oupjb30bxGerDuJ1J9YUWa23UaGn9HQEuipEk35DxQOD+Uhj
         pYrw==
X-Forwarded-Encrypted: i=1; AJvYcCXvm7ef6+WUlVwLzzSZ1gkEFl5VpnVuV0JwqP9kQZokf0OHQY0YQ32gf6HRlCtjyrNJRNYRZ6SoBHhD1LbF9RLmp9vBPgA3kHxXh90QUhUAqw==
X-Gm-Message-State: AOJu0YyGqFcRnu1p6dGXZbEl7LwSgNVqcHsiXb0AfdxtUh6yhpyl2Wtf
	/1aqO9h4vI6EOaLVWwJ4NCXZ7BP6XnMJY1iHFDOtQZtbYuEtlSmRYKwKnwW+7A==
X-Google-Smtp-Source: AGHT+IHN8eeXE9OsgItxEKHR70nrrazwBAjav29jEzJB0wGGmdP+iVlP1VjtMYRBUjqpRzzzPBgYhQ==
X-Received: by 2002:a05:6a20:c88b:b0:1a5:6a85:8ce9 with SMTP id adf61e73a8af0-1afc8d1b02amr3543639637.12.1715188296881;
        Wed, 08 May 2024 10:11:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lp9-20020a056a003d4900b006f44ed124dfsm9245352pfb.160.2024.05.08.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:11:36 -0700 (PDT)
Date: Wed, 8 May 2024 10:11:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Eric Dumazet <edumazet@google.com>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <202405080959.104A73A914@keescook>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424201234.3cc2b509@kernel.org>

On Wed, Apr 24, 2024 at 08:12:34PM -0700, Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Weißschuh wrote:
> > The series was split from my larger series sysctl-const series [0].
> > It only focusses on the proc_handlers but is an important step to be
> > able to move all static definitions of ctl_table into .rodata.
> 
> Split this per subsystem, please.

I've done a few painful API transitions before, and I don't think the
complexity of these changes needs a per-subsystem constification pass. I
think this series is the right approach, but that patch 11 will need
coordination with Linus. We regularly do system-wide prototype changes
like this right at the end of the merge window before -rc1 comes out.

The requirements are pretty simple: it needs to be a obvious changes
(this certainly is) and as close to 100% mechanical as possible. I think
patch 11 easily qualifies. Linus should be able to run the same Coccinelle
script and get nearly the same results, etc. And all the other changes
need to have landed. This change also has no "silent failure" conditions:
anything mismatched will immediately stand out.

So, have patches 1-10 go via their respective subsystems, and once all
of those are in Linus's tree, send patch 11 as a stand-alone PR.

(From patch 11, it looks like the seccomp read/write function changes
could be split out? I'll do that now...)

-Kees

-- 
Kees Cook
