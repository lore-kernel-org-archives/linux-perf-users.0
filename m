Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617A1AA783
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911257; cv=none; b=Dvt8E3ZZb3ba/UeVE294kryHHgz98+55tJ5vSBeJUm7sHJX0iqbYg3kwCKCA38xrhacLriB3kXilAvt/DPYU6UBhMrTWl2sxYcR7ODQVuB8GDiuBxbjwK43CJ3jHY5waNEmT9fOR7Oml7F2QLd6wfXO/18Fq0214jRWH/AIABes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911257; c=relaxed/simple;
	bh=N7i07W7JgKWJgaXhOdx1uMP7PnOAWhaXuytQvNK/7fo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bnyDBm5JtmjqW/Of0WPbWSCwdGnKCo0UbJSf51JcgYRuFv3k9N7TCeKjfaqprEMHl+pSylhAB8ytt4cCyg62/dRVgCaNuZqpyxZTe16XXOGD+79xJ1gAjsjVcDcf9OgJS2b8h1lavwlgbHyArCTE9qOLD9X2ZNtZ+95YJ38faEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISAP6ML/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISAP6ML/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728911254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vz/tKiNrcgfaOfQOUItP+eBpx3zXx1nT4M1JqYodY10=;
	b=ISAP6ML/lUixp7fBumAjfbOot+8kGsyEn2+vncroFjC4iseL50U6nsNVLR6MwTiY44Nn3f
	8mWRZkkhfaHQZX2qh86OoCZWsSknEkHCrM3JoexDaqGXNvBghnhOcDPdfhD51fh3iH7ofK
	GSa9Iotv09vBEimhhINC7N/ojloMLUk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-SAWN3ukaOJG4VqctiKMELg-1; Mon,
 14 Oct 2024 09:07:31 -0400
X-MC-Unique: SAWN3ukaOJG4VqctiKMELg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56C4419772D6;
	Mon, 14 Oct 2024 13:07:28 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 697CD1956088;
	Mon, 14 Oct 2024 13:07:21 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:07:17 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
To: vmolnaro@redhat.com
cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
    mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com, 
    namhyung@kernel.org, mark.rutland@arm.com, irogers@google.com, 
    alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
    adrian.hunter@intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf dso: Fix symtab_type for kmod compression
In-Reply-To: <20241010144836.16424-1-vmolnaro@redhat.com>
Message-ID: <0f2939d-b7ca-aa8e-8d2a-381b52d613a@redhat.com>
References: <20241010144836.16424-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, 10 Oct 2024, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> During the rework of the dso structure in patch ee756ef7491eafd an
> increment was forgotten for the symtab_type in case the data for
> the kernel module are compressed. This affects the probing of the
> kernel modules, which fails if the data are not already cached.
> 
> Increment the value of the symtab_type to its compressed variant so the
> data could be recovered successfully.
> 
> Fixes: ee756ef7491eafd7 ("perf dso: Add reference count checking and accessor functions")
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>

Acked-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Michael Petlan <mpetlan@redhat.com>

> ---
>  tools/perf/util/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index fad227b625d155c5..4f0ac998b0ccfd7a 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1343,7 +1343,7 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
>  	 * we need to update the symtab_type if needed.
>  	 */
>  	if (m->comp && is_kmod_dso(dso)) {
> -		dso__set_symtab_type(dso, dso__symtab_type(dso));
> +		dso__set_symtab_type(dso, dso__symtab_type(dso)+1);
>  		dso__set_comp(dso, m->comp);
>  	}
>  	map__put(map);
> -- 
> 2.43.0
> 
> 

