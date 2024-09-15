Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB91C578E
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Sep 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413509; cv=none; b=fVznBVgZ3E71T6sSmj8sHdYG2G4Ina8Bd2xkLMCPLQG/QpaOWBYoPhmtToZNqkH8Z8jfq33CvMLXQ0bJZx3++O3/rk53xEp8i+XV+OxuIubJPzMgd+3NvekM26zqHtpuWp3HTWEGeAmHX3/AeuGAZgypQBPizS15VLSot0K391I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413509; c=relaxed/simple;
	bh=HEkOL+SIIOorjKmQLQpDyWskuma7P7RHDiNjkYWeAX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGlB1AOtwKor81IpnoyRPiEED/T8XY1cy1nhESWSGmvzVbSoDHk8ca4Fo6twOzMhlHlMcTydAZntsrcYVy0lZdMSkjIb5pFYrrvaOcbjZAR6boc0WDOYQvbBffTydK3BntbsnxLjkgehFdH+NxH7hYtD7u0Bn9RtijXqZQvaeq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpEnEgeo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpEnEgeo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726413506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEkOL+SIIOorjKmQLQpDyWskuma7P7RHDiNjkYWeAX4=;
	b=EpEnEgeoyYGsWdDIZDTMzLOMlVKt9jbQjDOs8kub9FoMw7mhSdho1r+MDvP40VV7wQtPXF
	EIZ+fNjwJXf9VyC0F6PL8CVqxIjflI2M/0Sh4LIl/1R+SGaHREZ6w332wNnvWeEkXgqKTa
	uWkpRvt7iLEmkJcq57PgzJei49JkEtY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-bfz7UB-uO_CIuHYov_OE5A-1; Sun,
 15 Sep 2024 11:18:23 -0400
X-MC-Unique: bfz7UB-uO_CIuHYov_OE5A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D93319560AB;
	Sun, 15 Sep 2024 15:18:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A769119560AA;
	Sun, 15 Sep 2024 15:18:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 15 Sep 2024 17:18:08 +0200 (CEST)
Date: Sun, 15 Sep 2024 17:18:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v3 0/2] uprobes: Improve scalability by reducing the
 contention on siglock
Message-ID: <20240915151803.GD27726@redhat.com>
References: <20240815014629.2685155-1-liaochang1@huawei.com>
 <cfa88a34-617b-9a24-a648-55262a4e8a4c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa88a34-617b-9a24-a648-55262a4e8a4c@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Liao,

On 09/14, Liao, Chang wrote:
>
> Hi, Oleg
>
> Kindly ping.
>
> This series have been pending for a month. Is thre any issue I overlook?

Well, I have already acked both patches.

Please resend them to Peter/Masami, with my acks included.

Oleg.

