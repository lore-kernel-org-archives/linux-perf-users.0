Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1564338934
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811571; cv=none; b=fX7QBM7R48VN09idlIRrYe0WEDapptj3mK3NgK619NY1VVlKBa45dO/0eIFFUuNdCF5epfkk7JuRWd+VGUZ1weGQoDQbXD2A54oj1VOEvGpeAwCi+T/EVFNsHwRuuOSSkE489GVvHD/tTF0udPqVbeGwWfzk2jelNxfEWw7s/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811571; c=relaxed/simple;
	bh=lOLWB+sn53IEBJ2NfXNAqi9W2x7ka3pC9NCkNFlL6yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKGhnD5rJrF0EMWWkKkk1ckrn3MOZJJyyNhgG+XJBFNYr50/o/dz3Dq1aowabGYaajVSRu8nAd2Lg0EOBTS0mwzWuUUR3WZkRjDiVxMKQkP0l4OlLPgqGogRUPqvH47MQPp01CjbfiVf2smvPdffjv0T1EWAjLp14DZBf76ddJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bounIDoT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bounIDoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761811566;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=zBFIdlgABwYbbBOS3RkdoYsL1Gh/EHDnSfDmTuI8UhM=;
	b=bounIDoTM/x6oqIpya8TJQxPGDqaTgXgkZnJeOcEi8yIuoiAYcdkGyWp76UjrD8br3MfJ2
	I/koIAZe6LbMRgLR3tcyyFhkz+xRkhxAxxKrkicv0g16kQLk4Tc6u9FqDg3DpqkYRX67OH
	CF7GdmzubP5yqv9b3PJZeibQyU05cRw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-sRKpnhg7OSC5mR7r32yTQQ-1; Thu,
 30 Oct 2025 04:05:59 -0400
X-MC-Unique: sRKpnhg7OSC5mR7r32yTQQ-1
X-Mimecast-MFC-AGG-ID: sRKpnhg7OSC5mR7r32yTQQ_1761811558
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43A6B180A225;
	Thu, 30 Oct 2025 08:05:58 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.44.32.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B574B1800579;
	Thu, 30 Oct 2025 08:05:57 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
	by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 59U85sOE4065049
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 09:05:54 +0100
Received: (from jakub@localhost)
	by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 59U85stU4065048;
	Thu, 30 Oct 2025 09:05:54 +0100
Date: Thu, 30 Oct 2025 09:05:53 +0100
From: Jakub Jelinek <jakub@redhat.com>
To: Fangrui Song <maskray@sourceware.org>
Cc: linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <aQMcYe5BK+Rsu3xF@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <aQMUGvXv6sy75nKn@tucnak>
 <CAN30aBHOw16Tzdn_Z0TZKie7Fyi39bmB2PQK4LB-rjU1vn3zQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN30aBHOw16Tzdn_Z0TZKie7Fyi39bmB2PQK4LB-rjU1vn3zQQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Oct 30, 2025 at 12:50:42AM -0700, Fangrui Song wrote:
> An effective compact unwinding scheme needs to leverage ISA-specific properties.

Having 40-50 completely different unwinding schemes, one for each
architecture or even ISA subset, would be a complete nightmare.  Plus the
important property of DWARF is that it is easily extensible.  So, I think it
would be better to invent new DWARF DW_CFA_* arch specific opcodes which
would be a shorthand for the most common sequences of unwind info, or allow
the CIEs to define a library of DW_CFA_* sets perhaps with parameters which
would then be usable in the FDEs.  There are already some arch specific
opcodes, DW_CFA_GNU_window_save for SPARC and
DW_CFA_AARCH64_negate_ra_state_with_pc/DW_CFA_AARCH64_negate_ra_state for
AArch64, but if somebody took time to look through .eh_frame of many
binaries/libraries on several different distributions for particular arch
(so that there is no bias in what exact options those distros use etc.) and
found something that keeps repeating there commonly that could be shortened,
perhaps the assembler or linker could rewrite sequences of specific .cfi_*
directives into something equivalent but shorter once the extension opcodes
are added.  Though, there are only very few opcodes left, so taking them
should be done with great care and at least one should be left as a
multiplexer (single byte opcode followed by uleb128 code for further
operation + arguments).

	Jakub

