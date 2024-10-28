Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34621F426C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152125; cv=none; b=EC2Qmi7HskFphODsuDc9lbMQo1bwB7wM+K12ky5YQjdYXg9qpPUV12l+qx0D2bzSzyd0IN2hVOas9wB3Yekb5EakK//FaqH/yO47BH3gwkxWE3bvDC8vK5UKbTD1ARJBLb7GDvg1+H55Qlyh3BNZHyI9ljimKqWsS7hOfs57hz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152125; c=relaxed/simple;
	bh=DHx3V9c6d7RzA8Hica7IwbiE0hndkhK3ioMyo+uODqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sChPzVydvCWa1wl3R3I+WvHCNCqd3cLlrD2jVIjzQpYwcv54mCEiyHz3hPgdcPNpFO6RjKpm6fpmayE9m1NhYJdJLhjHhaMiLbfsYbEtsJ90GF9EMpselOyG+Zo0y66qRGvD0HdeCr2Kq+to1lk67DnD+nBcPGQ9kC2VEJ2rumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQBQc5ew; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQBQc5ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730152121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8f6rNRcHbHfSirLmOVvnWqIPco4XSliHtz6q5ZmdDI=;
	b=WQBQc5ewr2OGV6Qw7C5gw3s/NPudzwzP9G2l9jz19PuA7J/AY3bR4fuM4fx+oeeA3cajPC
	OXljIV+bm+BNuzw5BADqdgu1mlmvKrrT/PwE7XAlsAAn28PIOxamdAqy9kSss8bi7hPiPE
	6tcr4gKRd9QePNaJiUDNlcunY78OoUI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-M30AHQ37OOqJexREAoKPCA-1; Mon,
 28 Oct 2024 17:48:38 -0400
X-MC-Unique: M30AHQ37OOqJexREAoKPCA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B31C1955EEA;
	Mon, 28 Oct 2024 21:48:36 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.130])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E345819560AA;
	Mon, 28 Oct 2024 21:48:35 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.94.2)
	(envelope-from <fche@redhat.com>)
	id 1t5XbF-0006m0-AC; Mon, 28 Oct 2024 17:48:33 -0400
Date: Mon, 28 Oct 2024 17:48:33 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Francesco Nigro <fnigro@redhat.com>,
	Aaron Merey <amerey@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 perf-tools-next] perf probe: Fix retrieval of source
 files from a debuginfod server
Message-ID: <20241028214833.GB25044@redhat.com>
References: <ZyACsIFUETsr7-09@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyACsIFUETsr7-09@x1>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi -

> -		if (!get_source_from_debuginfod(raw_path, sbuild_id, new_path))
> +		char prefixed_raw_path[PATH_MAX];
> +
> +		path__join(prefixed_raw_path, sizeof(prefixed_raw_path), comp_dir, raw_path);
> +
> +		if (!get_source_from_debuginfod(prefixed_raw_path, sbuild_id, n
ew_path))

lgtm!

- FChE

