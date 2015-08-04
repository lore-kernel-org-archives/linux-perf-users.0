From: "Liang, Kan" <kan.liang@intel.com>
Subject: RE: Haswell LBR call stacks - broken
Date: Tue, 4 Aug 2015 21:41:47 +0000
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F077018D21C6@SHSMSX103.ccr.corp.intel.com>
References: <1682663.JO3lAz5bZo@agathebauer>
 <8643019.4YmQ1Xdl9W@milian-kdab2> <87h9oe3ox3.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31558 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbbHDVl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 17:41:57 -0400
In-Reply-To: <87h9oe3ox3.fsf@tassilo.jf.intel.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>, Milian Wolff <mail@milianw.de>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi Milian,

Is it possible to share your test case/steps with me?

Does --call-graph fp work?

Thanks,
Kan

> 
> Milian Wolff <mail@milianw.de> writes:
> >
> > OK, with a more recent perf v4.2.rc5 on a Intel(R) Core(TM) i7-4770
> > CPU @ 3.40GHz it actually works. Somewhat :) It is much faster, but
> > the callstacks don't terminate properly, and are sometimes not
> > correctly demangled. I observe the following behavior:
> >
> >     15.56%  ex_string_compa  libQt5Core.so.5.5.0   [.]
> QString::compare_helper
> >             |
> >             |--5.84%--
> >
> _ZN7QString14compare_helperEPK5QChariS2_iN2Qt15CaseSensitivityE@pl
> t
> 
> Maybe the demangler doesn't like the @plt.
> 
> 
> >             |          QString::compare_helper
> >             |          main
> >             |          |
> >             |          |--4.24%-- main
> >             |          |          |
> >             |          |          |--1.60%-- main
> >             |          |          |          |
> >             |          |          |          |--1.07%-- main
> 
> Yes that looks like a bug.
> 
> Adding Kan.
> 
> -Andi
> 
> >             |          |          |          |          |
> >             |          |          |          |          |--0.54%-- main
> >             |          |          |          |          |          main
> >             |          |          |          |          |
> >             |          |          |          |           --0.53%--
> > QString::compare_helper
> >             |          |          |          |                     main
> >             |          |          |          |
> >             |          |          |           --0.53%--
> > QString::compare_helper
> >             |          |          |                     main
> >             |          |          |                     main
> >             |          |          |
> > QString::compare_helper
> >             |          |          |                     main
> >             |          |          |
> > QString::compare_helper
> > ...
> >
> > The correct callgraph, as shown by --call-graph dwarf, is:
> >
> >     21.62%  ex_string_compa  libQt5Core.so.5.5.0   [.]
> QString::compare_helper
> >             |
> >             ---QString::compare_helper
> >                main
> >
> > Is this a known (undocumented) limitation or a bug? Is there anything
> > I could do to get this fixed?
> >
> > Thanks
> 
> --
> ak@linux.intel.com -- Speaking for myself only
