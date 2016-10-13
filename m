From: Andreas Arnez <arnez@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390: Add support for z13
Date: Thu, 13 Oct 2016 18:14:51 +0200
Message-ID: <m3eg3kcjk4.fsf@oc1027705133.ibm.com>
References: <m3mvnwu1cy.fsf@oc1027705133.ibm.com>
	<bb9acd86-0c7c-7291-00c1-1c6ad8576232@redhat.com>
	<m360p8m87d.fsf@oc1027705133.ibm.com>
	<d2177055-a1c3-7562-f555-bd239836af3e@redhat.com>
	<alpine.LRH.2.20.1610042254100.6819@Diego>
	<m3vax6lkon.fsf@oc1027705133.ibm.com>
	<alpine.LRH.2.20.1610121546540.14258@Diego>
	<44aa1856-f35d-4077-df94-c588d5b3b1e2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <44aa1856-f35d-4077-df94-c588d5b3b1e2@redhat.com> (William
	Cohen's message of "Wed, 12 Oct 2016 16:27:46 -0400")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: William Cohen <wcohen@redhat.com>
Cc: Andreas Krebbel <krebbel@linux.vnet.ibm.com>, oprofile-list@lists.sf.net, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Oct 12 2016, William Cohen wrote:

> Is there support for IBM z13 perf counters in the upstream linux
> kernel?  I didn't see perf support for IBM z13 in the mainline kernel
> git repository.

To my understanding, there is currently no support for z13-specific
counters, but generic counters should still work.  This certainly limits
the number of available counters on z13 significantly.

--
Andreas


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
