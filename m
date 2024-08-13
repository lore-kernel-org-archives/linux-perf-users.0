Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45F38FB9;
	Tue, 13 Aug 2024 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581693; cv=none; b=JETiJqjOa19JoIz/Halb84mh91HBIHU4ZI/siflfcDReUJwsiR0uMCYS4dwh9bz2FbIP4SjXZmjgT1mXKsUDsfp0YJQYZSQRQoFKfPxzQKtgxa1WxEsAZR/6JO5r0wz8AN1DmjYoJcvVv0ZldzmrxZqAsyU7fUWdCCzLzYYwD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581693; c=relaxed/simple;
	bh=OCH1Es03WkKCiYL9+NV4WfSbB5exMeXJmlvVQv+LiMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuq4b8QnETtOnKs1HPmzRpf3Tub8L9uo+vtG+wF/r88FmRchAyfVM5TXuiYeNYQ0lqcjzMGiW7Y/Bs+IOEOpRsGhXNL6mAlKRoJOwHO9gzAZCNchvEKX4cPHLU5/w3lb56WLYo6jX04/uolt9t48vS5eCsvEkABvy14CRWTJKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A367uxuD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A367uxuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3BFC32782;
	Tue, 13 Aug 2024 20:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723581693;
	bh=OCH1Es03WkKCiYL9+NV4WfSbB5exMeXJmlvVQv+LiMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A367uxuDGVmcxZ5/91pgpLL+eE06iSWu0eoVdn6ARqoSKR7zoXoQhImkP9gMVftS/
	 uazKULGWkUFB8gE/5KQdCDoRdG5k74nLShz35ZV7WGSP3vnqaD2xc67E/9VfWy57iE
	 TEs36AzBfhhRhjyi8onj7uxtQ67M0I/GWHzVOXbpvMNqQGC76Ih8s8VqE9wi+D5E1+
	 iXbM/U+ldcliD8EFudVnO2IHNnCYErV41BYdgne2W/uNP3+UjuVkHqoofuzZhn5Px8
	 wslJEkqTE7qQzNKOXlr1qWrMC8GzpT1wgzQ4dK8k8+p5aMF1M0hV4USDJotWnVExQx
	 4YIrfbE6wLfaA==
Date: Tue, 13 Aug 2024 17:41:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
Message-ID: <ZrvE-CR6ddxjcoDQ@x1>
References: <20240813040613.882075-1-irogers@google.com>
 <ZrtzTTHim_vGX1ma@x1>
 <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com>
 <ZruhsN4i6xtc59nJ@x1>
 <CAP-5=fXVrhanvW6vrUJsubuWUC4jBM5v_NOFp40cqTsqdHHNaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXVrhanvW6vrUJsubuWUC4jBM5v_NOFp40cqTsqdHHNaw@mail.gmail.com>

On Tue, Aug 13, 2024 at 12:11:21PM -0700, Ian Rogers wrote:
> On Tue, Aug 13, 2024 at 11:11 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Tue, Aug 13, 2024 at 09:04:57AM -0700, Ian Rogers wrote:
> > > On Tue, Aug 13, 2024 at 7:53 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> > > > > lock__parse calls disasm_line__parse passing
> > > > > &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> > > > > lock__delete.

> > > > > Found with lock/leak sanitizer.

> > > Ooops, I meant address/leak sanitizer.

> > > > Applied both patches to perf-tools-next.

> > > Thanks, could you fix the commit message.

> > Sure,
 
> Also, it'd be good if maybe Namhyung could take a look. I did things
> this way as it made sense to me, but we have nested things going on
> and potentially the free would be more natural in ins_ops__delete.

ins_ops__delete() would have to look it is operating on a lock operation
to access the right member of the unnamed union (locked) to get that
string pointer to free.

lock__delete() is the 'lock' destructor, that knows these details, so
its the right place to do the freeing.

I.e.:

static struct ins_ops lock_ops = {
        .free      = lock__delete,
        .parse     = lock__parse,
        .scnprintf = lock__scnprintf,
};

When it was introduced:

commit c46219ac34f0f365bac700ca6a10ef979c643233
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Sat May 12 13:26:20 2012 -0300

    perf annotate: Introduce ->free() method in ins_ops
    
    So that we don't special case disasm_line__free, allowing each
    instruction class to provide a specialized destructor, like is needed
    for 'lock'.

- Arnaldo
