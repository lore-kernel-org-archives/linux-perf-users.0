Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4B347BD1;
	Wed, 21 Jan 2026 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026366; cv=none; b=HUnvIPKdri8F2kzM8HmcR4BF93sQjWZkyw9uR6zboKzuuBdJ5NVGwsBEPK+d5WYvv1s/0RGf2wBPdEAnwoyZ1G4Ytim7g1KVOSzTif3bKLbTRw8vfhIK8nFvf2IIowlvm3/wUX64x2apntS8yc9dTKeoZ0Jdf/QRg4tdypFZIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026366; c=relaxed/simple;
	bh=hj98sqSLJGoAyR/XPsT3P1sw3welqFbz22SY8T0pBIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug4yCrTipPeavW+JygpaZFcI70/EtCRj2PW9obLYTUQO4ZfZswTQKIyuqv3Rpt5uWWXIWBDjN6gnqTyofhybNJ6KiXJlF4E93ew+ZxBfzOT68SsOj73cfUoRpR0yerzQ31uyhvOLxnHJOOqHi7dnio6gX7k21M6vFub0fJ7Hmdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pqm/xYL1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pqm/xYL1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hj98sqSLJGoAyR/XPsT3P1sw3welqFbz22SY8T0pBIg=; b=Pqm/xYL1C+RL7hnFCLSN/ppz31
	6Powf3mQ9bRM/ofyaQt4Q9eZZYHeLtWRqRrbknCp8rOMfgOWPjYZjpTIZmZOMbM4afNSgk/yYa8r1
	k6sEPSWWsHr4nm3nhaURZSAzqaDY+QEZctQ0cQ5n082yOdmzGdnXVOfxSJ2iHgPcz3yVSiluvC79C
	4XtzOKCgxzY+bdsTKOv8fTKr3ej0ckBg8ei0KhcC5lS8bkrp43AHSn+TzLdWqIRUzn0X5exjJ7+yH
	UJpkRAsG0YsZAF8uLYfEo+cG5d2cPcjNDXjXbE1tKY/apQff3jfQVrg5e5T5vpjai6D4r4klMoeSz
	RxWG0jcg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vieXD-0000000Gkz8-2sTz;
	Wed, 21 Jan 2026 20:10:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3ECA8300328; Wed, 21 Jan 2026 21:10:34 +0100 (CET)
Date: Wed, 21 Jan 2026 21:10:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, ravi.bangoria@amd.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
	blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
	graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	santosh.shukla@amd.com, sandipan.das@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, james.clark@arm.com
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
Message-ID: <20260121201034.GC171111@noisy.programming.kicks-ass.net>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>
 <20260121163342.GI166857@noisy.programming.kicks-ass.net>
 <CAP-5=fX=QuRw8M4Xco=A8WbBfDSPmyjtQ-JdnBEM-VRdX65_1g@mail.gmail.com>
 <20260121195155.GP166857@noisy.programming.kicks-ass.net>
 <aXEyJCSqlPPUS9YG@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXEyJCSqlPPUS9YG@x1>

On Wed, Jan 21, 2026 at 05:08:04PM -0300, Arnaldo Carvalho de Melo wrote:

> Until then, since you and Ian acked this one, I'm going over it and
> tentatively merging it,

Thanks!
