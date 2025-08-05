Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD87199252
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Aug 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754393697; cv=none; b=kR5wBRt7Nj5CdU8RbR2rPROofhTm3506ltadly2ep3HmXce2oaE7GpPKyKLXjV6BO/Fj2FzbZJVbqYkO1qcuwMNduZRdcX1Dz2EK889Vz0h9JPvsc86o4vE2hITiQxpaDiKbqcYtFpCTiSQUkJfUFwTqRyGKBKNn0sdDirLilyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754393697; c=relaxed/simple;
	bh=bMlKwWt4rFkPo2TtS4FbhcyCycJUaNwDVvqGkt0v4hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPy9OiJR31GIxcBjfl+JiIBrpMP88+5RGIo2ed80oAI3dAiY/ObLfhe0l3FJYvxKU6Sw2Iccf0AYFCceFqkoxJ/hVaD8GpQJU4l8I5bdKgjXu/2nn3KvE1/oygTNvgahJivvMTAhC1b93JZdsTNpNBSrIHqzv4jzl9cx9N7Yuos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMByCR6+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMByCR6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754393694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bMlKwWt4rFkPo2TtS4FbhcyCycJUaNwDVvqGkt0v4hE=;
	b=QMByCR6+6RR+OCtcJOB2RBmBwi2cwwaSm11X0SdOj20Is2ggMQa0hSA9ejNGa0cjLkGNg6
	n+5UfyRPI1HeialgTTCLkAvYf44EossdOO+B9BouGk5j/XGX5Hzly7iOjnYFSsGXJQtCxZ
	T0mVwzfcW+lY1J581UQw4eWgs9iCqEY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-qsO-pNuXPgqKnMq2961A7g-1; Tue,
 05 Aug 2025 07:34:52 -0400
X-MC-Unique: qsO-pNuXPgqKnMq2961A7g-1
X-Mimecast-MFC-AGG-ID: qsO-pNuXPgqKnMq2961A7g_1754393690
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7894C18001C6;
	Tue,  5 Aug 2025 11:34:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.134])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DD1591800298;
	Tue,  5 Aug 2025 11:34:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  5 Aug 2025 13:33:32 +0200 (CEST)
Date: Tue, 5 Aug 2025 13:33:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] uprobes: Remove redundant __GFP_NOWARN
Message-ID: <20250805113301.GA27131@redhat.com>
References: <20250805025000.346647-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805025000.346647-1-rongqianfeng@vivo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/05, Qianfeng Rong wrote:
>
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
>
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
>
> No functional changes.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Acked-by: Oleg Nesterov <oleg@redhat.com>

