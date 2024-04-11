Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9A1D639E
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855059; cv=none; b=XBg+Rwh820hX2l2nS6k3qwaBxVbj4oW/4CAEycHNgKbF2geoG6C/Ecdi8bwkJXXdiaybfvkfp0lDwHcCAgfuhJtm7Zb9Z5rDSRwBYZTyEot8yZB/wAupbLkaB29cyEFzPHBcGMUDn23224JPa41ioUZl6ooBMpETiunIAQTwnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855059; c=relaxed/simple;
	bh=QElmSC3bxNhYYUYZcpYqZWOnauAT+nnkD1ECMHNRsa0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c+0BKcxqR/q7UvAvVcNtz0AAFtIEBSF0J09zf0WXOZq1nuI+xz5TItL3qWWa5aeiSjXZhJvx4QAky4nOcFS2fRRj3r4FRQbJBDtWOza8Haz75BDila1JhDotl1SAm/dTy1umZa3L1aNvaFuRjUqxetUJfWFyUW7PsColZGFiKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjuyDxQs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjuyDxQs"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso49449276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712855057; x=1713459857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcI+w0jxD+jVMQpaBlv4eiJI48tJxddyR3AVpCAV8/0=;
        b=XjuyDxQsySmT1aw1XMjeSVmD0QOsLb5/m620JgishPaNvmKOy0iYE6RMeEhK1kUuww
         joHO6iZFRrWYwMUBTjwwFRfoVZN0RZ7X+pu8UFuW/p4O2++lr/zyAKgFVkPdN12iGogn
         RDw5tlt+wLQU4Xp5e/02kckNPaPXs/WYYWyfW15ATB6if2FfZn59cKlzBAMffYsN/tw+
         4gvXDj0/5/B0jMNvSHBcODIllPwWMYa+jHKPPVQgfcshI3XT9izok3B+LigxOkGTVmqc
         Al89od5Rkb2bR8L3Qd0iN60VzAIR2WXNdlgMmiNketcYXZ4nX57eA9eJoRKKAGZ0Vrbb
         wYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712855057; x=1713459857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcI+w0jxD+jVMQpaBlv4eiJI48tJxddyR3AVpCAV8/0=;
        b=JinujW0v1XoT+ZQ+h9yVRUXXIwW82B4IhF7ZmpFKYNF6ndLXad1Q+0Ng0lAUF3p7/f
         e4oWn9l4vZ3LUkJXFHHWfPIAUVSvny6MUzXS42i7ZVF9fl/nVac7ik6ZMCVPsMuSb34F
         k3vkvKDQ562LDiRqd9LCf/6FtfXxnSTgAx449+/tJqg4OoxvBW7PQj8VFLN9f8oKmfVe
         T0lw6JW2u9r1hfgRztWVKrdd9L0rPgzhQphT/CJEyGuB52ZdpSPUoXUHbl7is3B/amo9
         ZCxzCBQQDzvt4v3mePzs3Waab43VY9D93tVd8qzj/2WoYPvFaZvMJUNJtqY7RHY0f0qQ
         fLZw==
X-Forwarded-Encrypted: i=1; AJvYcCW5EqHa7wX4tzwAR29mtxwa6IFWOvJVe7VKQj0zAmxj8R5MyYneKxU8bmw1PFAzlw2oLD4Pe2MvP//PWepXxKerLU2EyYHMHb2X3lWIGFYLfA==
X-Gm-Message-State: AOJu0YyRBpR6veCXh5zu3khrf5LkEH79MYbK4RuB6CXKYoTYc9QV1Gl/
	F0kqF6Ebj0HyRXVf/e7dGz1HcG4lt5d7nbOxHZ/J657CLVDibdvdTxC5ySd7q7rm3WAH/32iGYZ
	ObA==
X-Google-Smtp-Source: AGHT+IF+kQ/A1q51nGdz/1jgB0BZ4jm+Y8FVRBtTG7jOydoNQbvoOHP3rKC1bCcsOLvoRnXL34a7l/KFutg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100b:b0:dcd:875:4c40 with SMTP id
 w11-20020a056902100b00b00dcd08754c40mr23995ybt.10.1712855057304; Thu, 11 Apr
 2024 10:04:17 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:04:15 -0700
In-Reply-To: <20240126085444.324918-2-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-2-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhgYD4B1szpbvlHq@google.com>
Subject: Re: [RFC PATCH 01/41] perf: x86/intel: Support PERF_PMU_CAP_VPMU_PASSTHROUGH
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Define and apply the PERF_PMU_CAP_VPMU_PASSTHROUGH flag for the version 4
> and later PMUs

Why?  I get that is an RFC, but it's not at all obvious to me why this needs to
take a dependency on v4+.
