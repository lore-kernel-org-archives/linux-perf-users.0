Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A2331ED2
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602682; cv=none; b=IMebiqAKVKmEZ1Dj/eMfSpYgvVgKwt3EtynkkEA++ofzVn9R6QxwbFkUr9mlUknSsCwJea/sGBYQ1LjCiy+VccX5qaErmFwfLdgDmTEhUWJABAzwF9uh/HL8l5ALc2zgyLp3HQvT6zhTpTxV5kPZSkUItkR/tbW12bhVijbxjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602682; c=relaxed/simple;
	bh=URsi7e4OR0JmX7pm3tlKz1+Fyzyx3DYb2+A8/wrbErk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO2+3v8nW5A3PERJOtdp7WeTQgMhnuFhaI+sIrfMAQyXa/cCnPDzFW+e2rUb7jprzS9DJFjCuO/w0OVUsfbaCn6vFRmpyI0dTMarPMMKJuwqEpiDnuPss5PJEKqPid/EYxo2cWHSZnfcs5/P/+OzW0JfI8e1weUXrF378v0J1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VejiYxAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VejiYxAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5128E1F000E9;
	Mon, 24 Aug 2026 20:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787602680;
	bh=7DfdJ6xuOTaxcsu0S0gIuc2F531lao+Uit7lhn9aNs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VejiYxAm7CZFstsBusK0rHtlObcR1D+/t3B/4H0XKgve/vU2BjxaskaG472T7e+v9
	 mzrLNQRemQ8Gu08ID3kufHLWtO8TnF3e23IYJOcomZK6hd73+T1GC2EdLAgAsmU2N6
	 k6p6qKSnKEB4qhoovzWWqqf3egSsAegZXan35JdYUBHoIJUfWF5CZFiq0XPyQniDxc
	 myvWV6HGScKKQCeO22D1KOu/R3NK2U3Y74F2pw45S5zaoNfbSY57MakgMlCZDwys5i
	 uUEKclz79q6A471qWHGe/BCbW/oGKcGw/qWAs5SODHn2cGhp76PRS2ArTzQD2tk21A
	 8avpR0o1JswMw==
Date: Mon, 24 Aug 2026 13:17:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Todd Lipcon <tlipcon@google.com>, Stephane Eranian <eranian@google.com>,
	"Mi, Dapeng1" <dapeng1.mi@intel.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf script intel_pt decoding reading instructions from wrong
 shared lib
Message-ID: <aoym9nq77PimB3fz@google.com>
References: <CAGH6UiG=RJLqBU3kLu9XJciPyPO1HZkbAPERguVUMRuWQgqf=A@mail.gmail.com>
 <c45fea55-b03d-40ac-a89f-8882b057fe5b@intel.com>
 <ajw8r2Y2shs6sBJW@google.com>
 <3a317e20-da30-484f-a3e0-a2e12ba5bcf0@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a317e20-da30-484f-a3e0-a2e12ba5bcf0@intel.com>

On Mon, Aug 24, 2026 at 08:26:37AM +0300, Adrian Hunter wrote:
> On 24/06/2026 23:23, Namhyung Kim wrote:
> > Hello,
> > 
> > On Tue, Jun 02, 2026 at 10:32:02PM +0300, Adrian Hunter wrote:
> >> On 15/04/2025 00:59, Todd Lipcon wrote:
> >>> Hi folks,
> >>>
> >>> It seems there may be a bug in perf-script when processing intel_pt.
> >>> Specifically, in order to reconstruct the instructions, it maps
> >>> instruction pointers back to DSO-relative addresses, and then reads
> >>> from the associated ELF files to find the actual instructions that
> >>> were traced.
> >>>
> >>> In the case that the ELF file has an associated separate-debug ELF
> >>> file linked via `.gnu-debuglink` (common in some Linux distros), it
> >>> appears to be reading the debuginfo file instead of the shared library
> >>> that actually contains the code.
> >>>
> >>> I've posted a simple repro here:
> >>> https://github.com/toddlipcon/perf-debuglink-bug/blob/main/repro.sh
> >>>
> >>> I haven't dug into the code yet enough to see where it's going wrong,
> >>> but figured I would report to the users list first.
> >>
> >> Seems to be caused by commit 5363c306787c8 - see further below.
> >> Reverting that makes the issue go away.
> > 
> > Sorry for the trouble.
> > 
> >>
> >> With that commit, dso__load() sets the binary_type to the first symbol
> >> source file type, which is DSO_BINARY_TYPE__DEBUGLINK in this case.
> >> That causes dso__get_filename() to get the file name of the debug file,
> >> not the file actually executed.
> >>
> >> Leaving the binary_type as DSO_BINARY_TYPE__NOT_FOUND will result in
> >> try_to_open_dso() using either DSO_BINARY_TYPE__BUILD_ID_CACHE or
> >> DSO_BINARY_TYPE__SYSTEM_PATH_DSO.
> > 
> > Ok, I feel like we should split the dso access for the binary file (for
> > annotate or intel-pt) and debug symbols (symbol table or DWARF).
> > Probably we can use the binary_type and symtab_type respectively.
> > 
> > I'll take a look.
> 
> Would it make sense to apply the workaround in the meantime?

Right, I couldn't find time for it so far. :(

Can you please send a formal patch?

Thanks,
Namhyung

