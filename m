Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AC1D3644
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967907; cv=none; b=VXbNNUycgHM4Lzfvb9072jkggp/o4D7Ja0WWkQmxPzgi7mB8vPXOj/d0GTEEQX8JUSlj79rNCsGndvZj7cWwiXmLCFIzf2CioSfHpxp8gqMPMjSVbCrg19DPzlncpreDuoxiKkcyyFev1M1fvGcbai2qTNZah70yNQhtQa1jhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967907; c=relaxed/simple;
	bh=4BGrJLScVZuQqgHXqLMQtm6GQK8gcTiM4ZXedyMnqx0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2h8ZUK8CMsMYzs2O1e6BV8D8cQ5Iv53ktmvs7pOh43AhtxpAcYcP2vQvBUUj/8kaM4F57MLYh1u6w0aod2lY4sxaNUTT3B3EUkPjW/y+GyAL9Jkzffm+EfeTlFQf7++Zx7L01uIGtb0NLBAo7EcJNuIe8PnURiAdx4bjz1uMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMR/LTIA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMR/LTIA"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2954ada861so1278329276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 00:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730967904; x=1731572704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGhRaLwgb6WVIdBGRr1tkcKbLwKCrcqHl71ppprFKvY=;
        b=QMR/LTIAT7mq6nFS+RcXrJU3IECbqRMT7TSv4dTePg7/HGHcorvl/PnNr6B9K+wzr1
         bH55OpsnXVDanIYIEyjfQsDI/tsCjzpI0z/3xjzJK91tDdpJCUCjyd/T/oV2FYVHam6u
         8RTIU1b3rvd/eESFculITzazgnyDxEGnMOTayUJRO3u4JbmpIPIK0v5LcIFPlsiZ1iec
         DPcTwgrkfwtcpBy3oXgVI2kifu3hmGrPN94RGp0jtDahx4KA71IJFLhhqbdiRfYGVfTC
         KTxiQxz0EIe/sqQ2saaiUQDlw263ljIfft+ptaYAGzUbVZKCFtZ2l1SeKITTkuftKWZX
         G9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730967904; x=1731572704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGhRaLwgb6WVIdBGRr1tkcKbLwKCrcqHl71ppprFKvY=;
        b=RQuYSBLq6C29tUPNE3H057FyjGBQrpkZt27H9mDD+hDQqxVei9X/0EmzhE2u4w/ek6
         Ws31KhzOet8qsuW4KOzcSqqDPWzhdxdKRkfaqXC66cqfNrhpZRVnWKYbqpa7sc/BXxJE
         dKqTCeLBxKyPpB3ZDRRUfHWLrIg7JBX0YL7NOZ0/CXiqbsg+Y9G4Ee+2BruNSuFF6iNK
         d4lM+BcwwLpDsOWLxwXHHdVD2/QbL1ogarWGUnVXlCtNt6vK5mGGnk5UbeP5957mq2KY
         d/f+fq0o1BNPb8SYVXj1sJNJV+NmvxVcdhiwNSDByGUt9s7T19heUcj9mkTpnGYf5JFf
         JHjw==
X-Forwarded-Encrypted: i=1; AJvYcCV/vDxGlTSlXckIMpZmA4RKZPQqwv9XUE6M7J1vdfvIrDsmUZS9BKicaQDwGIo/o9hFVy8OkXotpUPionPNxHsa@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9GX2Yqoy2/v6jKCq/gnhDbRHuti6QMBYEMgJtIGHwB3m9k4e
	oESNO7gj9GGi2Cc165FUP3BCMUZV0CdpHMudbJRP9WMSsN1cmA0UYQ9nAwxbyWVd0ycP0vWQ9g=
	=
X-Google-Smtp-Source: AGHT+IGKApV4pLTstVZBfNTnB9kI/yOx0XaDKSNs1NJZP0R4EVrNuUnwTT/oWpllImRadHPWEXtYyU1GiA==
X-Received: from liuweina.c.googlers.com ([fda3:e722:ac3:cc00:99:2717:ac13:e22f])
 (user=wnliu job=sendgmr) by 2002:a25:aace:0:b0:e28:f35b:c719 with SMTP id
 3f1490d57ef6-e3087bd6066mr76652276.6.1730967904402; Thu, 07 Nov 2024 00:25:04
 -0800 (PST)
Date: Thu,  7 Nov 2024 08:25:02 +0000
In-Reply-To: <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107082502.4060233-1-wnliu@google.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
From: Weinan Liu <wnliu@google.com>
To: jpoimboe@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, andrii.nakryiko@gmail.com, 
	broonie@kernel.org, fweimer@redhat.com, indu.bhagat@oracle.com, 
	irogers@google.com, jolsa@kernel.org, jordalgo@meta.com, jremus@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-toolchains@vger.kernel.org, linux-trace-kernel@vger.kerne.org, 
	luto@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	mingo@kernel.org, namhyung@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, sam@gentoo.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
...
> +static int find_fre(struct sframe_section *sec, struct sframe_fde *fde,
> +		    unsigned long ip, struct unwind_user_frame *frame)
> +{
> +	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> +	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
> +	unsigned char offset_count, offset_size;
> +	s32 cfa_off, ra_off, fp_off, ip_off;
> +	void __user *f, *last_f = NULL;
> +	unsigned char addr_size;
> +	u32 last_fre_ip_off = 0;
> +	u8 fre_info = 0;
> +	int i;
> +
> +	addr_size = fre_type_to_size(fre_type);
> +	if (!addr_size)
> +		return -EINVAL;
> +
> +	ip_off = ip - (sec->sframe_addr + fde->start_addr);

nit: Since we already know wether the ip_off should mask or not, I think we don't have to check fde_type and mask the ip_off everytime.
	ip_off = (fde_type == SFRAME_FDE_TYPE_PCINC) ? ip_off : ip_off % fde->rep_size;

> +
> +	f = (void __user *)sec->fres_addr + fde->fres_off;
> +
> +	for (i = 0; i < fde->fres_num; i++) {
> +		u32 fre_ip_off;
> +
> +		SFRAME_GET_USER(fre_ip_off, f, addr_size);
> +
> +		if (fre_ip_off < last_fre_ip_off)
> +			return -EINVAL;
> +
> +		last_fre_ip_off = fre_ip_off;
> +
> +		if (fde_type == SFRAME_FDE_TYPE_PCINC) {
> +			if (ip_off < fre_ip_off)
> +				break;
> +		} else {
> +			/* SFRAME_FDE_TYPE_PCMASK */
> +			if (ip_off % fde->rep_size < fre_ip_off)
> +				break;
> +		}
> +
> +		SFRAME_GET_USER(fre_info, f, 1);
> +
> +		offset_count = SFRAME_FRE_OFFSET_COUNT(fre_info);
> +		offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(fre_info));
> +
> +		if (!offset_count || !offset_size)
> +			return -EINVAL;
> +
> +		last_f = f;
> +		f += offset_count * offset_size;
> +	}
> +
> +	if (!last_f)
> +		return -EINVAL;
> +
> +	f = last_f;
> +
> +	SFRAME_GET_USER(cfa_off, f, offset_size);
> +	offset_count--;
> +
> +	ra_off = sec->ra_off;
> +	if (!ra_off) {
> +		if (!offset_count--)
> +			return -EINVAL;
> +
> +		SFRAME_GET_USER(ra_off, f, offset_size);
> +	}
> +
> +	fp_off = sec->fp_off;
> +	if (!fp_off && offset_count) {
> +		offset_count--;
> +		SFRAME_GET_USER(fp_off, f, offset_size);
> +	}
> +
> +	if (offset_count)
> +		return -EINVAL;
> +
> +	frame->cfa_off = cfa_off;
> +	frame->ra_off = ra_off;
> +	frame->fp_off = fp_off;
> +	frame->use_fp = SFRAME_FRE_CFA_BASE_REG_ID(fre_info) == SFRAME_BASE_REG_FP;
> +
> +	return 0;
> +}
