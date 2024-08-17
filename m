Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EDD7DA97;
	Sat, 17 Aug 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723897397; cv=none; b=QfpEtVrC/j/EAYrnCn3TAKdV5qsr4W2h1YOq1zgm+falZb/icaFxqP00k2YnlO1hnRuy0LZPh0xsIq6sgvEWk12P6j4l6b1H9tZ7XldMWMK7biMzdjcQp1lIyBASN6sAlCIQha8cZGSqIgxqbN+jc8wZNw9sOgjLK45rNt0FHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723897397; c=relaxed/simple;
	bh=dHWX1SdrRQ3+NHhcPCDipEoG6DZEdRjwQN6EQqRzqOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NhDFp96dRtwLDKaDu2SNbKGwtsf8C+gbTfODV6JtOSS7Y6rLQFiacdOvXADJ6cJvL0qXEsHUFAKCh2UMpwT65Q7ae3Sne+7sewbJT0Hd8cS7PjI01B7t0V2lc9XpqPHmkVTS1cKY0nER5XAuj2Fg5Mtn+btMRZ1R5YXFve8VETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S9J9SCMu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+eh/8WeN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9J9SCMu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+eh/8WeN"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723897388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0pDMQ1csewAZjVObVNdm6EOoseVhQ4C3pzjLXmRpsEs=;
	b=S9J9SCMuuU/XZZ9Zgq9rXGp0LHLod0TzKdK50rKTFm+70D83Xo70xE6BOliMWf8vUDV+pN
	2cWedD/+6zJ6JqRjg/O1VQHMtgAf7WlqyMWgZnvJdlsv2uYoO1okMWm+1IDVJZDeNzSL0l
	gTdYcHShtKMSzFZFS8C6tVUKLbt98id9mKfD59CN57wAjApFPaA0viieR5bxZQaTS5KR9w
	F2dXH50CTBVStsH+WwZAnUZbjs5F3MJW+0oXtssITTtBgnRJp62GvFkiOQyzFx/IW1IvMD
	MwQw61chA8n8WrHdc/c05oqdbaomYIhxPpQC6iO5tmKDpZcg3V+SWQ/qdR8Jzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723897388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0pDMQ1csewAZjVObVNdm6EOoseVhQ4C3pzjLXmRpsEs=;
	b=+eh/8WeNOsV8xRg8hx0BakthH9HtsyLtHNbeMQgXSLYD3Nr8xBNf1YFV+5UT6TPkJSZLbX
	gIbaClIXTPjESCDA==
To: "Liang, Kan" <kan.liang@linux.intel.com>, Li Huafei
 <lihuafei1@huawei.com>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Vince
 Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
In-Reply-To: <705dc2fe-7ab3-458a-9b5a-7ea0b30756b8@linux.intel.com>
References: <87sev7nom4.ffs@tglx>
 <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com>
 <87frr7nd28.ffs@tglx>
 <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com>
 <875xs2oh69.ffs@tglx>
 <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com>
 <87wmkhlk1l.ffs@tglx>
 <059d6217-10a5-4d2a-b639-90806c04a13b@linux.intel.com>
 <87plq9l5d2.ffs@tglx>
 <705dc2fe-7ab3-458a-9b5a-7ea0b30756b8@linux.intel.com>
Date: Sat, 17 Aug 2024 14:23:07 +0200
Message-ID: <87cym7l4no.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 16 2024 at 15:27, Kan Liang wrote:
> On 2024-08-15 7:43 p.m., Thomas Gleixner wrote:
>
> The HSW11 is also BDM11. It sounds like we need the trick from both bdw
> and nhm.
>
> How about this?
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index e8bd45556c30..42f557a128b9 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4664,6 +4664,12 @@ static void nhm_limit_period(struct perf_event
> *event, s64 *left)
>  	*left = max(*left, 32LL);
>  }
>
> +static void hsw_limit_period(struct perf_event *event, s64 *left)
> +{
> +	nhm_limit_period(event, left);
> +	bdw_limit_period(event, left);
> +}
>  static void glc_limit_period(struct perf_event *event, s64 *left)
>  {
>  	if (event->attr.precise_ip == 3)
>
> Do you plan to post the "limit" patch for HSW?
> Or should I send the patch?

Go wild...
