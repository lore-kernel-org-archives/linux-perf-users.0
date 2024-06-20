Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7491AAE2F
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880832; cv=none; b=ILyJNodsCizlb4Th9UfY29v86ity6889LztMxsaH8J7hrC/AbrwSvMOngbbEkl61NHa6Q8z96hbLjv+C5jZ0Evixugt4YsdGce53MGTvTQMzVomwldA2KqU+UF1riDoZBaFJiesp7V9J0T9pWBVKTL2s9JoScwI1HKQRoKKTOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880832; c=relaxed/simple;
	bh=YhVNZVJotcrbQnNA0C2ERjJ5On3FcuCmck5hLWMIyPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEd/6+Z7553cXkm+ct5eLoqX+L8LoTMppRUyK0LWOuJiQNm8z/Y/vDQBMvJGEeSm1P0oew67fzIHZLuUbdkyK3PAWVysL5Mz6AmuAFcIRndgmZnzXbsiAJnbjmyJ07gVJBPUKFXVYPK0wVZqp28UXO3vjOpJrOXu1X+YJJt3xsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRU3dDIA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRU3dDIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718880830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhVNZVJotcrbQnNA0C2ERjJ5On3FcuCmck5hLWMIyPk=;
	b=NRU3dDIAWCtUlumL8YskEUyO4s0XFAIu8OJUtknnPBdpRd1u+7XY/PrHw9arecQgtC4hmU
	MXJIhYdQ+pDuV+G+AjHo27DKg5DtrxyLtzfKnY9cGw9+/WGvBZ5Fu+tiMWtIMCGP/ZaV0F
	NhW5HDjCEQB7aah4eL2hnKH1nbbUDdg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-cEh00LHwMS2gzgbBqp2q3A-1; Thu,
 20 Jun 2024 06:53:43 -0400
X-MC-Unique: cEh00LHwMS2gzgbBqp2q3A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2B4C19560B0;
	Thu, 20 Jun 2024 10:53:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.26])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D396F1955E80;
	Thu, 20 Jun 2024 10:53:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Jun 2024 12:52:09 +0200 (CEST)
Date: Thu, 20 Jun 2024 12:52:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	nathan@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
Message-ID: <20240620105203.GE30070@redhat.com>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <20240619143852.GA24240@redhat.com>
 <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
 <20240620083602.GB30070@redhat.com>
 <f0678e11-dd59-2e9b-56d5-cb28a20ffac7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0678e11-dd59-2e9b-56d5-cb28a20ffac7@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/20, Liao, Chang wrote:
>
> 在 2024/6/20 16:36, Oleg Nesterov 写道:
> > On 06/20, Liao, Chang wrote:
> >>
> >> However, when i asm porting uretprobe trampoline to arm64
> >> to explore its benefits on that architecture, i discovered the problem that
> >> single slot is not large enought for trampoline code.
> >
> > Ah, but then I'd suggest to make the changelog more clear. It looks as
> > if the problem was introduced by the patch from Jiri. Note that we was
> > confused as well ;)
>
> Perhaps i should use 'RFC' in the subject line, instead of 'PATCH'?

Well. IMO the changelog should explain that the current code is correct,
but you are going to change arm64 and arch_uprobe_trampoline(psize) on
arm64 can return with *psize > UPROBE_XOL_SLOT_BYTES.

Oleg.

