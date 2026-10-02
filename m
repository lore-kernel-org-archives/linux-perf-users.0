Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB94F96B8;
	Fri,  2 Oct 2026 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958879; cv=none; b=be5nwmZ9UYVehHvmrm09gL9suosdWPnwoiNfqJrRhuulQKfVuK8nIVZFfw6LXxmRxDt8xWfxbqit9MvesuILI0BCkhMEWc/w2uR6Ox3Q8upcSeNjys746wYTp9Bgn3Z5F/WIcDYDEQDOXYV0xqW5BF8mPcgY5nXs3RXfYT8y4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958879; c=relaxed/simple;
	bh=FYNXgjp2/tK/2ukmTFdVmqp6QxyToCC7neg0WdoofYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frnsXGTSsLmMvdLCHUn+ZueSoXIz/Gow/I6vrCADBN7Gp1u9JowjiJ5skF/W1sAYWuJ1edOXyBcGVT03dV10Y5LZmVQzv7lsh0WbXjeHsEwDVb3MLLN5WvViPhS00q1EC8jto+74uiPBny9MkQtO/hepyQqOeIiSqqxkXLfPkCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXCNGr1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXCNGr1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3EA1F000FF;
	Fri,  2 Oct 2026 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958878;
	bh=hcFa7b/H7Mv/Fa86u8RtAP4grByz6LW4RCbjITTeJow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dXCNGr1N/9dqisH4En5S/98sPy872OEuNS5ocZtUjQMQNmc50CeZT3F0Xsw/hqtN1
	 ks+KEVi4L/TtQW2YDiCBjx0wh0nWWGDFGIRHdAltBlCNFtb5rE10Yeqm0+HT7LziGo
	 IwiVMAGXCxlrhlIA7ZenIph8sZ9jEVV0lKbTYY46gGyS4MAMu+srgD8AAUxmDBMZ73
	 pCHwWJNX2HXoGdT+AcycBn0/IETzTdrmqmc2MZOJaEt3YHXLFsTi7N9oHC2qIqi+Jy
	 jcvEn5PhOs6WC930C5gOPxGW2g7EsOiJ/oSM97TFFApCuWDo2jsjB+1G0nfLI/3w2p
	 b3/JxfQS12KpA==
Date: Fri, 2 Oct 2026 18:34:33 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Yanbo Zhao <yzhao62@ncsu.edu>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf dwarf-aux: Add die_is_compound_type() to
 handle C++ class types
Message-ID: <ar_dGYiNoo04-OEK@x2>
References: <20260930210038.196928-1-yzhao62@ncsu.edu>
 <20260930210038.196928-2-yzhao62@ncsu.edu>
 <20260930211051.8EFDA1F000FF@smtp.kernel.org>
 <ar6i_ZKXNVZmze2r@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar6i_ZKXNVZmze2r@google.com>

On Thu, Oct 01, 2026 at 11:14:21AM -0700, Namhyung Kim wrote:
> On Wed, Sep 30, 2026 at 09:10:51PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [High] perf/dwarf-aux: stack overflow in __die_find_member_offset_cb via cyclic inheritance
> > - [Medium] perf/dwarf-aux: flex array detection fails for C++ classes
> > --
> > 
> > commit 3f3b9b56b2e28f1713af3b40ab8946d5bbc8d245
> > Author: Yanbo Zhao <yzhao62@ncsu.edu>
> > 
> > perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
> > 
> > This commit introduces die_is_compound_type() to support C++ classes alongside
> > structs and unions. It also updates offset lookups to descend into base class
> > subobjects using DW_TAG_inheritance entries.
> > 
> > > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > > index 54f8b5ec74a2f..eb4b8f3475df1 100644
> > > --- a/tools/perf/util/dwarf-aux.c
> > > +++ b/tools/perf/util/dwarf-aux.c
> > > @@ -61,6 +61,14 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
> > >  	return dwarf_formstring(&attr);
> > >  }
> > >  
> > > +bool die_is_compound_type(Dwarf_Die *type_die)
> > > +{
> > > +	int tag = dwarf_tag(type_die);
> > > +
> > > +	return tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
> > > +	       tag == DW_TAG_class_type;
> > > +}
> > 
> > [Severity: Medium]
> > Does die_has_flex_array_recurse() also need to be updated to use this new
> > helper?
> > 
> > If we look at die_has_flex_array_recurse() in tools/perf/util/dwarf-aux.c,
> > it currently forces flex array detection to return false for C++ classes
> > because it explicitly ignores DW_TAG_class_type:
> > 
> >     if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type)
> >         return false;
> >     ...
> >     if (tag == DW_TAG_structure_type && found) {
> >         if (is_flex_array_member(&last_mb))
> >             return true;
> > 
> > Could this cause accesses to flex array members inside C++ classes to be
> > wrongly rejected as out-of-bounds?
 
> IIUC C++ officially doesn't support flexible arrays and there are
> better alternatives so I guess it's rare to see them in C++ classes.
> Maybe it's ok to ignore them until we find it's really needed.

ok on both counts, there is another patch with a Sashiko report, can you
guys reply to that one as well?

Thanks,

- Arnaldo
