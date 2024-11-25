Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516C1BBBDD
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Nov 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561974; cv=none; b=RtQFzjgSIjd2e3PBy5mxco3GQH90cPga4Um39CQC9bkBgGGnjFVS2B9rTZqZwgJXeeqm1clHQHduJXZNZLs3jHUh1g1FhndFT6sf0QKtoNGKbHnnKA8NFRumN2TZEmCz5BiN2vGROBSXJQg5ao2y0iUbPklB4TnMQacpRmIwRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561974; c=relaxed/simple;
	bh=Pm0J1cdCvKpFt7XYh6vATRYNjy/Xb+mbWmai0b7xhFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN399SBgXzJqlmMPzW7eUci1Pi05yHCWTQdhcQgOe5eKXdx/1nCQ94Xmbh5A0B2Hy20cXXENPiJXthchG+nQw9CQgZXa+mc3+BALbc6s1wu2hGn330Me0QfECwsZk9oxHbb7dC82pWsbPmy8pph2LeFrDlpgsSw7jzCMAQK988w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dhaxgv3V; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dhaxgv3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732561972; x=1764097972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pm0J1cdCvKpFt7XYh6vATRYNjy/Xb+mbWmai0b7xhFk=;
  b=Dhaxgv3VAhh+ffQKkJcCN1PCXMsekERAAqHVw+Dk9I8d+Wi/JzEiCUPD
   tyTyxUNQO0fF07z7+laZ1gOfM5igX7gl+AU82y3rdEEgAMpw1F/O3wpLg
   +DMMtBkMlrNuZeYUCFRGn5TH0/lKIS+ExYvJrM+tc/kTDy41G+vGOgaLm
   VNUxN8KXtrnxR2XMiS1JStSNoIpdUQ2JBUi4WLpx6sUnTTKbu2W7W4whk
   iqYxvbZHrRe94EJMBPo8U+DoZFhvUBthqrUMuOLeGHQ8olOHhuZb35AU/
   3O3zstGAg5zkcVgMwsVb2KrG1wBB0bANNpm2x4WguNDcu7ZQAW6odWWS3
   w==;
X-CSE-ConnectionGUID: px01TCqCRfqDJU3dYrWTCA==
X-CSE-MsgGUID: 4OURlzgQTdSm7rTzvFAqtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43757539"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43757539"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:12:52 -0800
X-CSE-ConnectionGUID: ih2tOFLXRly1rGdq9eXqfg==
X-CSE-MsgGUID: wKShlx2KTnKY1PG5d35Diw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91500267"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:12:52 -0800
Date: Mon, 25 Nov 2024 11:12:50 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: namhyung@kernel.org, linux-perf-users@vger.kernel.org,
	"Yann E. MORIN" <yann.morin.1998@free.fr>,
	"buildroot@buildroot.org" <buildroot@buildroot.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 1/4] Create source symlink in perf object dir
Message-ID: <Z0TMMouXlvhyk6j3@tassilo>
References: <20240807231823.898979-1-ak@linux.intel.com>
 <20241125182506.38af9907@booty>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125182506.38af9907@booty>

On Mon, Nov 25, 2024 at 06:25:06PM +0100, Luca Ceresoli wrote:
> Hello Andi,
> 
> +cc Yann and the Buildroot mailing list (see the end of this report).
> 
> On Wed,  7 Aug 2024 16:18:20 -0700
> Andi Kleen <ak@linux.intel.com> wrote:
> 
> > Create a source symlink to the original source in the objdir.
> > This is similar to what the main kernel build script does.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/Makefile.perf | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 175e4c7898f0..d46892d8223b 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -163,6 +163,8 @@ ifneq ($(OUTPUT),)
> >  # for flex/bison parsers.
> >  VPATH += $(OUTPUT)
> >  export VPATH
> > +# create symlink to the original source
> > +SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
> 
> I found that since this patch got applied in 890a1961c812 (v6.12-rc1)
> building perf fails silently in some cases.
> 
> The cases I have tested:
>  - make <FLAGS> -C tools/perf                       -> OK
>  - make <FLAGS> -C tools/perf O=/my/out/of/tree/dir -> OK
>  - make <FLAGS> -C tools/perf O=tools/perf          -> fails
> 
> The failure in the third case is silent: make exits with a return value
> of 0, but there is no perf executable created.

The failing case is incorrect arguments because the O= is relative to -C 
and there is no tools/perf/tools/perf

But yes a error message would be good.

Could just ignore the linking error, so that you hopefully get a better
error message later.

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9dd2e8d3f3c9..18f639ec853b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -164,7 +164,7 @@ ifneq ($(OUTPUT),)
 VPATH += $(OUTPUT)
 export VPATH
 # create symlink to the original source
-SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
+SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source || true)
 endif
 
 ifeq ($(V),1)
