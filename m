Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB413515D7;
	Fri, 14 Aug 2026 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786688043; cv=none; b=etFfGYvX08CcGV+zBxUJ7PnNSJI3d4bsz1ErCDB1rRK1rcw5vFYB9P77mm2z2hgxaOOKTsrpBSRrh+SDD9lAc8IuD0S0qX117lutrXptW8nSZeF4YefPc2YQTtcoMgLmND20TaucRSDN9Fy+bSGUZmBs9N7ldmpl9P/HkNUOCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786688043; c=relaxed/simple;
	bh=UHvDfU78EGvPf6BP7gER1fA0Nlcr0aoeJOUgFfnBG0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De0YxQWO6LKV1euJXt0RmEx4+uNMXLRXscRCw/9SVKyoOjOnRefzwbalcsXaGELRNLSkdJBmZHqs9Qo4eGRlX42fHYhF1vhzt4KVk06GDQc+St5N/+rqpLvi8bntvNhs8Gd/8T7DYWmhOPbD3ZDyavSq9WhxMTXiJ6JJHvRdXUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3QfsRuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3QfsRuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0381F000E9;
	Fri, 14 Aug 2026 06:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786688041;
	bh=xsdZrWjRwM+MlLLn49Nz99arDPFtsOPDOEn2X5ZMzEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N3QfsRuSWenrEdVWZkv0SxGSC2Btr/uuFUk2ptQvu0KZOCQhBarUnx1bcXI8XHMPS
	 iwoSTM9uxga6ZPZ5EdyNOuQnAjC+1lwQLvVmfbg+17elPtYiG9sohKiFlHiYW/f/iU
	 1kI4wt2rccEQ9TxLyDZZ01u87+9WmZ0uQxuXhtzRGbBAD0wAHK/uB89qzI1OqqNhSD
	 0wkjn4ZrjttUTKK/JYMIii1Agwl0RHNIvL40n6JM47n9byeshR4PCSnMZ5E8vnbPtW
	 uGuGDEmWgiz7zEqUOS8vyGSsrwOn5E8h9IXkzA7PQWfCttovfBT1GYq1RSWmkNKwCv
	 ktZLtuLV2KJOQ==
Date: Fri, 14 Aug 2026 15:13:57 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/9] perf c2c: add function view browser skeleton
Message-ID: <an6yJfWlWtBp49Nf@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com>
 <20260810052647.588867-3-jiebin.sun@intel.com>
 <anwuHmiI7DCOCm4T@google.com>
 <20260814032306.2055624-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814032306.2055624-1-jiebin.sun@intel.com>

On Fri, Aug 14, 2026 at 11:23:04AM +0800, Jiebin Sun wrote:
> Hi Namhyung,
> 
> > Considering function view in stdio, wouldn't it be better to move the
> > common code to util/c2c.c instead?
> 
> Good point. Since this series only adds the TUI function view and has no
> stdio caller yet, I would prefer to defer the split until stdio support is
> implemented, when the shared interface is clearer.

My concern is that the later split would move the code as is and just
make the history complex unnecessarily.

> 
> Would that be acceptable? If you prefer the separation in this series, I
> can move the common model to a separate util/c2c-function.c and keep the
> TUI code in ui/browsers/c2c-function.c.

Let's start with things very clearly separated.  It's up to you but I
prefer having obviously common code in the common location.

Thanks,
Namhyung
