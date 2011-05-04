From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: vmlinux buildid doesn't match the running one
 (/sys/kernel/notes)
Date: Wed, 04 May 2011 21:12:25 +0800
Message-ID: <1304514745.2624.3.camel@localhost>
References: <BANLkTim+kr6TYdkuh=bugJaNmSnLE0h-8Q@mail.gmail.com>
	 <BANLkTikfDmsZ056G+Eht2BbNH4GVBokXzw@mail.gmail.com>
	 <BANLkTikauRD6CF3MuBmuvQqJAuDPHE2x-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15300 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196Ab1EDNMY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 May 2011 09:12:24 -0400
In-Reply-To: <BANLkTikauRD6CF3MuBmuvQqJAuDPHE2x-Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: francis.moro@gmail.com
Cc: linux-perf-users@vger.kernel.org


> From: Francis Moreau <francis.moro@gmail.com>
> Date: Mon, May 2, 2011 at 3:02 AM
> Subject: Re: vmlinux buildid doesn't match the running one (/sys/kernel/notes)
> To: linux-perf-users@vger.kernel.org
> 
> 
> Hi,
> 
> Sorry for asking again but I would be really greatfull is someone can
> tell me what's wrong when using a kernel that I compiled by my own.
> 
> I do not have that issue is I use the kernel shipped by my distro (FC14).
> 
> Thanks
> 
> On Thu, Apr 28, 2011 at 7:04 PM, Francis Moreau <francis.moro@gmail.com> wrote:
> > Hello,
> >
> > I'm trying to use perf-probe, but it fails.
> >
> > Basically it's due to the buildid of the running kernel (the one which
> > can be read from /sys/kernel/notes) and the one in vmlinx (which I
> > compiled my self).
> >
> > I did this:
> >
> >  $ make
> >  $ make modules_install install
> >  $ ls vmlinux
> >  vmlinux
> >
> > reboot

Could you make sure you indeed reboot with the new kernel running?

Use below patch to dump the 2 build_ids.

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 516876d..4b66c1c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1036,6 +1036,15 @@ static size_t elf_addr_to_index(Elf *elf, GElf_Addr addr)
 	return -1;
 }
 
+static void dump_build_id(u8 *build_id)
+{
+	int i;
+
+	for (i = 0; i < BUILD_ID_SIZE; i++)
+		printf("%02x ", build_id[i]);
+	printf("\n");
+}
+
 static int dso__load_sym(struct dso *dso, struct map *map, const char *name,
 			 int fd, symbol_filter_t filter, int kmodule,
 			 int want_symtab)
@@ -1075,8 +1084,11 @@ static int dso__load_sym(struct dso *dso, struct map *map, const char *name,
 				      BUILD_ID_SIZE) != BUILD_ID_SIZE)
 			goto out_elf_end;
 
-		if (!dso__build_id_equal(dso, build_id))
+		if (!dso__build_id_equal(dso, build_id)) {
+			dump_build_id(build_id);
+			dump_build_id(dso->build_id);
 			goto out_elf_end;
+		}
 	}
 
 	sec = elf_section_by_name(elf, &ehdr, &shdr, ".symtab", NULL);


> >
> >  $ perf probe -k vmlinux -L schedule
> >  Failed to find path of kernel module.
> >  Failed to open debuginfo file.
> >  Error: Failed to show lines. (-2)
> >
> > So my question is why the buildids doesn't match ?
> >
> > I guess I did something wrong since it's pretty a standard use case
> > but I don't see why...
> >
> > Thanks
> > --
> > Francis
