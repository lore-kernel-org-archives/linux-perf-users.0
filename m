Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3962E03E3
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415493; cv=none; b=AHPJ/wy3XjyaLulPz5U6mm9UJ5IyKPK2H8Czs6lESjmDXAe/IAfablhntfJcwDLcgp+uVVKwGP3Hek2dLd3D+Ne88T/VyoxWUKcdN5DkjFPdgvPcEgQ15uv/Cnv03Px7DQB4A7gjJ4Z/uvGL21mPAjohUnZc07eBJMTnLB0bksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415493; c=relaxed/simple;
	bh=K65aaEqq/YB61r4p7ihT0ItAeEpKgQgbAjU3OugTSoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EFd9UsRoO29ecsAxp46sptJ25jb61fcNXjZA/aXmU/weJE6cQ4rt2DNKpbrubznJGXNtsWH0VA+MVc3Hs6z4f7++0YcIUAmrtPS7GdhWxWYVkJAEh6HzM6glyvBo+NLufMfCzH75xPEmGCl/cmah+C/e7734Pja3MKG28qG3zME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8VJ+nfa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8VJ+nfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762415490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/narQH7oBzjR+CHzap2CS6luEPNI9uaK+xgrYacn+w=;
	b=f8VJ+nfaVlZo6E6oiajGdSYmRwVZts0co/zxkRoICNDQcEI5deoCMTxw2FinT0yQ/V9Wxb
	i3pq7tdIc8N1TWa2YFlI2jk8JXeyGxETj/hJztQqFVIIvS3+vSlzWZnuVdho7Zhh7zAdPS
	G3yVlIrq1dY/b8mrfZXnuWjujgvgBHI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-ecT11MeyOWeocyapa6M-Fg-1; Thu,
 06 Nov 2025 02:51:27 -0500
X-MC-Unique: ecT11MeyOWeocyapa6M-Fg-1
X-Mimecast-MFC-AGG-ID: ecT11MeyOWeocyapa6M-Fg_1762415486
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4019F180047F;
	Thu,  6 Nov 2025 07:51:26 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.98])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C20C18002B6;
	Thu,  6 Nov 2025 07:51:24 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Fangrui Song <maskray@sourceware.org>,
  linux-toolchains@vger.kernel.org,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
In-Reply-To: <9c11b765-66df-46f3-b4ea-a0c7f52dac35@oracle.com> (Indu Bhagat's
	message of "Wed, 5 Nov 2025 16:44:24 -0800")
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
	<2d713719-709d-4b46-8234-2dfe948b836a@oracle.com>
	<CAN30aBGEpwA+ZROXufqBL6MHM70oWTtNpGSioCMhxT8yS2t-Pg@mail.gmail.com>
	<9c11b765-66df-46f3-b4ea-a0c7f52dac35@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 06 Nov 2025 08:51:22 +0100
Message-ID: <lhuikfniop1.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

* Indu Bhagat:

> PLT stubs may use stack (push to stack). As per the document "A null
> frame (MODE = 8) is the simplest possible frame, with no allocated
> stack of either kind (hence no saved registers)".  So null frame can
> be used for PLT only if the functions invoking the PLT stub were using
> an RBP-based frame.  Isnt it ?

I think I said this before, but I don't think new toolchain features
need to support lazy binding.  Without lazy bindings, the PLT stubs do
not change the stack pointer or frame pointer and just make a tail call.

Do you see a need for continued support of lazy binding?

Thanks,
Florian

