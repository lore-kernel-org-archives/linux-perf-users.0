Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D28EEC0;
	Wed, 16 Sep 2026 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789537751; cv=none; b=Hthqey3N58Re5IbuCGfMBA3D/rKbtP93PO2tCnX3V14bhvON6Womm3gbWrSAWo10iES1DecCF88IiwnilXOh+Xoggb2jMnPxjko+oqGKQdycSVodW8yNUGcH5t7Z0Q/pdkhTxIDibmbvPJmRcudeYiFc0aWplM/TfwFjPnbmAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789537751; c=relaxed/simple;
	bh=lziBggu69h9KNBzb8PLdHD72h9TVXi9jRF1hdHoK0qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuk4wgQAKuuURyNR7sWaFRGKJuLT2HJbxMKmEdWUS7EJx8U/Sp92K9PbLXd804rbMip4B/L2gcBn9vcyC3Bc4je473N2EOINOoWnkJBnB5Cjm+Ihq2t90cBqPVrjcgFbDJ0uLNKoPejJsl/nyLwE7yHsubmLVXK5sQXxFbiUxeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0vFPoSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0vFPoSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451681F000FF;
	Wed, 16 Sep 2026 05:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789537750;
	bh=tnnqNWDL3gCrsGV2/KVDeikYUGTzB8wLESnnqKmTIfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D0vFPoSQwHn6SrGgtZCiTuLvpG3OKnediSAzud7ESyLNdIfFQi9+K4IrAB9uOeBSz
	 hSA0pXVYwhzEcPhpbbiGGoOSM9Q9UKCotCDoS8hmXKwQKa987k2R0/hdk9rhvZ0cWJ
	 F/e8EyvF94x1hzFOS2K+FL6xUwApyGOzobHvAr4tdXFKixCEEw1W82/c5FPHvILEXc
	 gLX6KeCS/PT3vZP7QVd4wowyIUlRhyCR9AJ63E9k/d0XdDu9gKncdwGph9ufmxkCH7
	 Jj8asvKR8RRCNClaJCydO36wTWnw9Jw/uBcwvoGI6O99ITT+UD9Sv4SmA8+RO/e6I1
	 06pBU0djK8HNA==
Date: Tue, 15 Sep 2026 22:49:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf dwarf-aux: Add die_has_flex_array() helper
Message-ID: <aqot1TR0mgeZPugR@google.com>
References: <20260915064035.1970175-1-namhyung@kernel.org>
 <20260915064035.1970175-2-namhyung@kernel.org>
 <20260915065027.29A8D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915065027.29A8D1F000FF@smtp.kernel.org>

On Tue, Sep 15, 2026 at 06:50:26AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] perf dwarf-aux: incorrect offset comparison masks flex arrays after empty structs
> - [Medium] perf dwarf-aux: missing DW_AT_data_bit_offset support causes member offset collapse
> - [Medium] perf dwarf-aux: top-level type resolution drops const/volatile modifiers
> --
> 
> commit 93f74aec3d433215197c18f94befb7b584381fa4
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf dwarf-aux: Add die_has_flex_array() helper
> 
> This commit adds the die_has_flex_array() helper to identify if a given
> DWARF type is a compound type containing a flexible array at the end. It
> also introduces a depth parameter to the internal recursive function to
> prevent infinite recursion.
> 
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index d7160f87ac7d7..a5aefe7d1d62d 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> 
> [ ... ]
> 
> > +		if (tag == DW_TAG_structure_type) {
> > +			if (die_get_data_member_location(&die_mem, &loc) < 0)
> > +				loc = 0;
> 
> [Severity: Medium]
> Will this fallback to 0 corrupt the tracking of the final member if the
> struct contains members using DWARF 5 DW_AT_data_bit_offset?
> 
> When die_get_data_member_location() returns < 0 for bit-offset attributes,
> setting loc = 0 silently overrides the actual offset. This could cause the
> maximum-offset calculation to fail.

I don't think we are interested in bitfield members.  I suspect it's not
possible to have a flexible array with bitfields?

> 
> > +
> > +			if (!found || last_loc < loc) {
> > +				memcpy(&last_mb, &die_mem, sizeof(last_mb));
> > +				last_loc = loc;
> > +			}
> 
> [Severity: Medium]
> Does this strict inequality prevent the tracking variable from updating to
> the true final member if multiple members share the same maximum offset?
> 
> If a struct ends with an empty struct followed by a flexible array, both
> members will have the exact same byte offset. Using a strict less-than
> comparison means the tracking variable won't update to the flexible array.
> This could lead to false negatives when analyzing binaries built with GNU C
> empty struct extensions.

Fair enough, will update with the same offset too.

> 
> > +		}
> > +
> > +		found = true;
> > +	} while (dwarf_siblingof(&die_mem, &die_mem) == 0);
> 
> [ ... ]
> 
> > +bool die_has_flex_array(Dwarf_Die *type_die)
> > +{
> > +	Dwarf_Die real_type;
> > +
> > +	if (dwarf_tag(type_die) == DW_TAG_typedef) {
> > +		if (die_get_real_type(type_die, &real_type) == NULL)
> > +			return false;
> > +
> > +		type_die = &real_type;
> > +	}
> > +
> > +	return die_has_flex_array_recurse(type_die, 0);
> > +}
> 
> [Severity: Medium]
> Does this type stripping logic ignore standard qualifiers like const or
> volatile?
> 
> By explicitly limiting type resolution to DW_TAG_typedef, variables
> declared as const struct foo or volatile struct foo will pass a
> DW_TAG_const_type or DW_TAG_volatile_type directly to
> die_has_flex_array_recurse(). The recursive function will then reject it
> because its tag is not a struct or union, causing flexible arrays in
> qualified types to be silently ignored.

Ok, I'll skip qualifiers as well.

Thanks,
Namhyung

