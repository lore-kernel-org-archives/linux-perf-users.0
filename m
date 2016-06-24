From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf record and intel_cqm/llc_occupancy
Date: Fri, 24 Jun 2016 09:43:50 -0700
Message-ID: <20160624164350.GZ13997@two.firstfloor.org>
References: <etPan.576ab1e0.2383613b.84d3@cern.ch>
 <8760szocdp.fsf@tassilo.jf.intel.com>
 <8760szocdp.fsf@tassilo.jf.intel.com>
 <etPan.576d272f.5dac2143.108@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:47457 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbcFXQnx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 24 Jun 2016 12:43:53 -0400
Content-Disposition: inline
In-Reply-To: <etPan.576d272f.5dac2143.108@cern.ch>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Omar Awile <omar.awile@cern.ch>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Aram Santogidis <aram.santogidis@cern.ch>, kan.liang@intel.com

On Fri, Jun 24, 2016 at 12:27:27PM +0000, Omar Awile wrote:
> Hi Andi,
>=20
> Thanks, I see your point. I=E2=80=99ve seen tried perf stat for these=
 events, which is quite nice. However, we would like to be able to corr=
elate the cache occupancy with the current call stack. I don=E2=80=99t =
see how this could be done with perf stat. Is there a way to do this?

perf stat cannot collect call graphs.

>=20
> Alternatively, since perf record already keeps track of the call stac=
k, is it feasible to extend it to allow recording cache occupancy, or i=
s this inherently impossible?

perf can collect counts while sampling another event (called leader
sampling using :S). Unfortunately this does not work with events from
different PMUs, which would be needed here. Kan looked into this
some time ago, but there were too many problems with it.

>=20
> Finally, if none of the two alternatives work, do you have an idea ho=
w else this could be achieved?

=46or now the only way would be to sample and perf stat record in paral=
lel
and then merge the data based on the time stamps. It likely will not
be very accurate.

-Andi
