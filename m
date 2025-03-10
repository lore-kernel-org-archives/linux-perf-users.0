Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0222D7AD
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626253; cv=none; b=bZpm/LOLPZYKAfsSH3zbGv485jnmjgGh+eF/QHIzR9aP3lIgQ2VzEIBnQlMD0v95CmUmfw3nfC2ZtELdKzdOJyxVXZ/4KSMRA96JWnre5HZURSi5G63ftB3fMuHSvx7LcpwDnMFRwYSgVqtNb3JXppnyjduka1kcvlOJMEu4FxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626253; c=relaxed/simple;
	bh=2iHTQcPXH1FLrxQMiNT55fa/PnOIlAodbQMDjn30aQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL1Rg/HaZH+vh08YSOnOyG5OiB1IYD/dK79rM0+PyE97DOabJJ6me2ciHxDmvsqdJdtfeT0Zo3wQEA/0zsKUwg5H2clPtWguNdDDwA4P7sH1Q+AL295AIkAH4EKF6OaMJyls5zQ2pMdmIBZI5klWhhFPnVzFP7of9NB5xwV0eRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UI0l+O5e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI0l+O5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741626251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7S8yd6R0h6QkbjSSTjEPq0BtEAD/xvKVvoWKNDxzjI=;
	b=UI0l+O5ehc38NNBR0puKp4TKnmZ2om4xOQML+H3FVI7EzZBYLEjoZ+thsTynl3BVP7y+91
	yaKy4KG1zNNWBrG/tGRntFncsYXLz/3PePkPbc/RYvSz73MQrDBYJgzy33gvEsW5a/9Ki/
	qaLwTRKz3LF9issEZKhTsA5nOYhxSt0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-qcA6nO9WNJ6cidPgFWXLFQ-1; Mon,
 10 Mar 2025 13:04:08 -0400
X-MC-Unique: qcA6nO9WNJ6cidPgFWXLFQ-1
X-Mimecast-MFC-AGG-ID: qcA6nO9WNJ6cidPgFWXLFQ_1741626245
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3444E1800349;
	Mon, 10 Mar 2025 17:04:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.34])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 310AD1956094;
	Mon, 10 Mar 2025 17:03:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Mar 2025 18:03:32 +0100 (CET)
Date: Mon, 10 Mar 2025 18:03:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH -next v1 3/3] kernel/events/uprobes:
 uprobe_write_opcode() rewrite
Message-ID: <20250310170320.GC26382@redhat.com>
References: <20250304154846.1937958-1-david@redhat.com>
 <20250304154846.1937958-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154846.1937958-4-david@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/04, David Hildenbrand wrote:
>
> uprobe_write_opcode() does some pretty low-level things that really, it
> shouldn't be doing:

Agreed. Thanks again for doing this.

David, as I said, I can't review. I don't understand this mm/folio magic
with or without your changes.

However. With your changes the code looks "better" and more understandable
to me. So I'd vote for your patches even if I can't ack them.

But I'd like to ask some stupid (no, really) questions.
__uprobe_write_opcode() does:

	/* We're done if we don't find an anonymous folio when unregistering. */
	if (!folio_test_anon(folio))
		return is_register ? -EFAULT : 0;

Yes, but we do not expect !folio_test_anon() if register == true, right?
See also below.

	/* Verify that the page content is still as expected. */
	if (verify_opcode(fw->page, opcode_vaddr, &opcode) <= 0) {
		set_pte_at(vma->vm_mm, vaddr, fw->ptep, fw->pte);
		return -EAGAIN;
	}

The caller, uprobe_write_opcode(), has already called verify_opcode(),
why do we need to re-check?

But whatever reason we have. Can we change uprobe_write_opcode() to
"delay" put_page() and instead of

	/* Walk the page tables again, to perform the actual update. */
	folio = folio_walk_start(&fw, vma, vaddr, 0);
	if (folio) {
		ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr,
					    opcode);
		folio_walk_end(&fw, vma);
	} else {
		ret = -EAGAIN;
	}

do something like

	/* Walk the page tables again, to perform the actual update. */
	ret = -EAGAIN;
	folio = folio_walk_start(&fw, vma, vaddr, 0);
	if (folio) {
		if (fw.page == page) {
			WARN_ON(is_register && !folio_test_anon(folio));
			ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr,
					            opcode);
		}
		folio_walk_end(&fw, vma);
	}

?

Once again, I am not trying to review. I am trying to understand the
basics of your code.

Thanks,

Oleg.

