From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Getting PEBS to work
Date: Tue, 24 May 2016 12:17:26 +0200
Message-ID: <20160524101726.GS3193@twins.programming.kicks-ass.net>
References: <CAE40pdfx+LMiwXMZNaLVkT_XsaYFmQQqW5iOr63JnCfOhkFBmQ@mail.gmail.com>
 <CAPAnC4NObR7Fe-fZr9z5tdD0cyyVhd6WojN-aWst2Z2rtxQ6SQ@mail.gmail.com>
 <CAE40pdehnoK4yO-050=0cfbw8viegNmiXKUZYxw8nMXgi6TGzg@mail.gmail.com>
 <alpine.DEB.2.20.1605192045590.18235@macbook-air>
 <CAE40pddwJZOikG2kS9z7pwhPgvBsupKsskangpX2FZriQ3ERmQ@mail.gmail.com>
 <20160523140539.GF8897@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39039 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbcEXKRb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 May 2016 06:17:31 -0400
Content-Disposition: inline
In-Reply-To: <20160523140539.GF8897@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>, Vince Weaver <vincent.weaver@maine.edu>, jim mauro <jim.mauro@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Mon, May 23, 2016 at 11:05:39AM -0300, Arnaldo Carvalho de Melo wrote:
> > # dmesg | egrep -i 'pmu|pmc|pebs'
> > [    0.381095] Performance Events: PEBS fmt1+, 16-deep LBR,
> > SandyBridge events, full-width counters, Intel PMU driver.
> > [    0.381101] perf_event_intel: PEBS disabled due to CPU errata,
> > please upgrade microcode
> > [    0.395348] NMI watchdog: enabled on all CPUs, permanently consumes
> > one hw-PMU counter.
> > [    1.231836] nouveau  [     PMC][0000:01:00.0] MSI interrupts enabled
> > 
> > Gah, it was there all along!
> 
> Wish this was exported by the kernel somehow, then tooling could emit a
> sensible message :-\

You mean something like so?

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1716,6 +1716,8 @@ ssize_t x86_event_sysfs_show(char *page,
 	return ret;
 }
 
+static struct attribute *x86_pmu_attrs[];
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -1779,6 +1781,9 @@ static int __init init_hw_perf_events(vo
 			x86_pmu_events_group.attrs = tmp;
 	}
 
+	if (!x86_pmu.pebs)
+		x86_pmu_attrs[1] = NULL;
+
 	pr_info("... version:                %d\n",     x86_pmu.version);
 	pr_info("... bit width:              %d\n",     x86_pmu.cntval_bits);
 	pr_info("... generic registers:      %d\n",     x86_pmu.num_counters);
@@ -2120,10 +2125,20 @@ static ssize_t set_attr_rdpmc(struct dev
 	return count;
 }
 
+static ssize_t pebs_show(struct device *cdev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	return snprintf(buf, 40, "%d\n",
+			!!(x86_pmu.pebs_active && !x86_pmu.pebs_broken));
+}
+
 static DEVICE_ATTR(rdpmc, S_IRUSR | S_IWUSR, get_attr_rdpmc, set_attr_rdpmc);
+static DEVICE_ATTR_RO(pebs);
 
 static struct attribute *x86_pmu_attrs[] = {
 	&dev_attr_rdpmc.attr,
+	&dev_attr_pebs.attr,
 	NULL,
 };
 
