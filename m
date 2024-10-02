Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74748194137
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857119; cv=none; b=sITb9ndt/KkBGVMer14LOPV76yvt539OkyurxqD1FIoTYnh8cXWZVXpuxUaVYN3L2v7VpXfAlOPgHnZ/TPAhucpYdQ7SA/JY6ioNgrO9dDc5OncYN6yDIoimgMn/1N7HHXKn8ZjMgfJE1VKflK7UxeHBcCZO/43Igz94xZdJqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857119; c=relaxed/simple;
	bh=wJVCp4FehMf5NAm3TKsTE0m3ux6IezBuOVnf1Rgz47g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B3ZgO9W8a0XYyW0FQT97tJOlg+MELqBjusbjBuT3Xakh4g6S0EO4hdD8NFEcnNZ5KXwDGaFdLmggbEz0xaXpYG3Ei++5VXsG/BosBLUpOlGibOUE2lSRIXz4YLnPHsnX+krL7cm769KDFPUp1NloW5srNmax2ITwTPpOYtpVM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmX83bru; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmX83bru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727857117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CyZ75Q7jVvp4hIButKipfE0sivhqX9OeiDRfPpeziWY=;
	b=HmX83brujBp7EbdQuxNmtLP14JKHseKVrBaA+1gBMxuj+m+2SXh1MRtkIRf2eZEh5DdlRe
	IurPEQq94mrrKQBpBMxINUo12j7deLNF6xFOEU9w7YxCl5ntwq9c4cVDDPkudpVSmNg4QS
	gSYYtsoZLd2Y7PF2+eqTnQwTbpVCYbw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-xhltjiE-P32NMoNjMkIK_Q-1; Wed,
 02 Oct 2024 04:18:36 -0400
X-MC-Unique: xhltjiE-P32NMoNjMkIK_Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFC1019560AB;
	Wed,  2 Oct 2024 08:18:31 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.151])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07F0D1956056;
	Wed,  2 Oct 2024 08:18:24 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>,  Josh Poimboeuf
 <jpoimboe@kernel.org>,  x86@kernel.org,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@kernel.org>,  Arnaldo Carvalho
 de Melo <acme@kernel.org>,  linux-kernel@vger.kernel.org,  Mark Rutland
 <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,
  Namhyung Kim <namhyung@kernel.org>,  Ian Rogers <irogers@google.com>,
  Adrian Hunter <adrian.hunter@intel.com>,
  linux-perf-users@vger.kernel.org,  Mark Brown <broonie@kernel.org>,
  linux-toolchains@vger.kernel.org,  Jordan Rome <jordalgo@meta.com>,  Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v2 03/11] unwind: Introduce SFrame user space unwinding
In-Reply-To: <20241001143624.08291d00@gandalf.local.home> (Steven Rostedt's
	message of "Tue, 1 Oct 2024 14:36:24 -0400")
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<ca2e603ae3dcfa3e836162ed8c301fd4d9fd4058.1726268190.git.jpoimboe@kernel.org>
	<20240914072358.4afad691@rorschach.local.home>
	<d2e7a4aa-2fd3-4b6f-b6e4-66b11e89d6ae@oracle.com>
	<20241001143624.08291d00@gandalf.local.home>
Date: Wed, 02 Oct 2024 10:18:21 +0200
Message-ID: <87frpegboy.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Steven Rostedt:

> On Tue, 1 Oct 2024 11:20:35 -0700
> Indu Bhagat <indu.bhagat@oracle.com> wrote:
>
>> > So we trust user space to have this table sorted?
>> >   
>> 
>> GNU ld will create this table sorted when linking .sframe sections and 
>> will set SFRAME_F_FDE_SORTED in flags in the output .sframe section.  In 
>> the current patch, I see the __sframe_add_section () includes a check 
>> for SFRAME_F_FDE_SORTED for admitting SFrame sections.
>> 
>> So proceeding here with the assumption that the SFrame FDE list is 
>> sorted should work fine.
>
> No not at all! We *cannot trust* user space. This could lead to a security
> hole if we assume it's sorted. The kernel must not trust anything it
> receives from user space. Because an attacker will be looking for ways to
> confuse the kernel to exploit it.

I don't quite understand, sorry.

Doing a binary search on an unordered table fails to find some entries
that could be discovered by a linear scan.  But an attacker could just
as well use an incomplete table from the start.  So assuming an ordered
table seems rather unlikely to introduce additional problems.  (Given
the lack of a formal threat model, it's impossible to make more precise
claims in either direction.)

Thanks,
Florian

