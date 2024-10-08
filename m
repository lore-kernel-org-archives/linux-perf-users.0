Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC81DED65
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421257; cv=none; b=AC/l+54NRil1KCQT8QUwXWL/zePS2/EGqabjL7mbi6BDNIkSzvVD02x5xroNgrNQxpJcFjB8O26YiuwOp7qbXNY1w96BS9MNuR2rWqfykF2FP6wOU6p+Y0ocyuFEscPwM66xy1G/uhiMUut2Fd5ZcpGHpeNWp5xwX3Nr52+YtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421257; c=relaxed/simple;
	bh=hSP4caUXb1lqceIzod7nqEOD9nZbs/TIw0s247yucas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXfm/Ajw5PXn4izuERZQVPWqIkC7lISLDwu/OIAoCYGb4uQmxt9BjJoFr0FqOJgE8TNSbD9Mm8nlv+PgllBRFzXqUGMjzXzhZy+0P7UvQhkPjUERQ+5xiCJi3Vt0l9UOx6L9ltsmijwnuc019aQlfrU/SFLUFI5VG8wsoDXkGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2a8vSyM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2a8vSyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F532C4CEC7;
	Tue,  8 Oct 2024 21:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728421256;
	bh=hSP4caUXb1lqceIzod7nqEOD9nZbs/TIw0s247yucas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2a8vSyMVpqJMR6kNlhonYZSscgzw0hRZd5Pvxii/QPccSyvMKPnyPd1U+cUZ/Qa4
	 r8jqdekHYSVglp+VHWAWM/UPC9UmzGBZddJQ1m06dExR8m5wOp7U5drEdOpAQ6j0i9
	 ZB289mOPa2b2FtDC9LCp0t/dj2PD/3NT8hdq0UOqi1HSYGLL/QnC45dBGOq9HcY2KT
	 /Mt4lMrG1mkpqSXaf+EjRyCNQmyShhFZ3syj2TyY6vCnG9eX1bO9qL1g+q0r1ms5At
	 KQP/x6Ai1dKWZh7B2nPBQY6Gef2mKQgji7eVeP9uQuXd6/OH6B7ezMxb7u/mlu2MU/
	 zQTEke62YgLeQ==
Date: Tue, 8 Oct 2024 14:00:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: leo.yan@arm.com, james.clark@linaro.org, mike.leach@linaro.org,
	suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V8 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
Message-ID: <ZwWdhvud5f7tRxkW@google.com>
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <ZwTIbRbAX2EX31X8@google.com>
 <c2b1d122-83e5-4392-9009-2d22e59aa14a@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2b1d122-83e5-4392-9009-2d22e59aa14a@os.amperecomputing.com>

On Tue, Oct 08, 2024 at 11:24:45AM -0700, Steve Clevenger wrote:
> 
> Hello Namhyung,
> 
> Sorry your question is so late. I don't include the ELF headers here,
> but the problem can be seen with a perf.data packet dump of user
> instruction trace capture. The problem is with the non-zero pgoff. The
> arm-cs-trace-disasm.py script was never passed pgoff information to
> adjust the start/end disassemble range passed to objdump. This patch
> distributes the fix between perf and the arm-cs-trace-disasm.py script.
> 
> Here's a brief excerpt from an e-mail I sent to James Clark describing
> the patch before I submitted it.

Oh, is it applied to the coresight tree already?  I don't think I got
any notification for that.  Please make sure to notify perf maintainers
(and hopefullly to get Ack's) when you touch non-coresight part of the
code.

Also I think we need to clarify how to route coresight tool patches.  I
thought they are going through the perf-tools tree.  But it doesn't seem
to be the case?

Anyway, sorry about being late on this.

> 
> -----------------------------------------------------------------
> .
> .
> This e-mail is to document what I know and don’t know about the problem.
> The background is Fedora 38 introduced non-zero text offsets into common
> shared objects and executables (e.g. libc.so.6, etc.).
> 
> If you were to ‘perf report --dump’ the perf.data of a user mode
> instruction trace on Fedora 37 and grep the PERF_RECORD_MMAP2 packets
> you’ll notice all zero values (@ 0) for shared binary and executable
> text offsets. Repeat the same for user trace collected on Fedora 38/39,
> and these text offsets show as non-zero.
> 
> Fedora 37:
> 
> 4294967295 18446744073709551615 0x8ac8 [0x78]: PERF_RECORD_MMAP2
> 2389577/2389577: [0xffff85124000(0x42000) @ 0 103:04 805306555
> 1941233998]: r-xp /usr/lib/ld-linux-aarch64.so.1
> 4294967295 18446744073709551615 0x8b40 [0x60]: PERF_RECORD_MMAP2
> 2389577/2389577: [0xffff85161000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
> 4294967295 18446744073709551615 0x8ba0 [0x68]: PERF_RECORD_MMAP2
> 2389577/2389577: [0xaaaab09b0000(0x10000) @ 0 103:04 1140851919
> 994218038]: r-xp /usr/bin/dd
> 4294967295 18446744073709551615 0x8c08 [0x70]: PERF_RECORD_MMAP2
> 2389577/2389577: [0xffff84f70000(0x1a9000) @ 0 103:04 1677721733
> 3891973508]: r-xp /usr/lib64/libc.so.6
> 
> Fedora 39:
> 
> 4294967295 18446744073709551615 0x8ac8 [0x78]: PERF_RECORD_MMAP2
> 18229/18229: [0xffffa5512000(0x1d000) @ 0x10000 103:04 161 4093340249]:
> r-xp /usr/lib/ld-linux-aarch64.so.1
> 4294967295 18446744073709551615 0x8b40 [0x60]: PERF_RECORD_MMAP2
> 18229/18229: [0xffffa554f000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
> 4294967295 18446744073709551615 0x8ba0 [0x68]: PERF_RECORD_MMAP2
> 18229/18229: [0xaaaade7e0000(0xb000) @ 0x10000 103:04 536876423
> 421616320]: r-xp /usr/bin/dd
> 4294967295 18446744073709551615 0x8c08 [0x70]: PERF_RECORD_MMAP2
> 18229/18229: [0xffffa5360000(0x11f000) @ 0x30000 103:04 536873199
> 2415801053]: r-xp /usr/lib64/libc.so.6
> 
> The arm-cs-trace-disasm.py script never gets to see the text offset into
> the dso binaries, so has no opportunity to adjust the start/end address
> range passed to objdump. This wasn’t a problem on Fedora 37 and below
> since there’s no start/end adjustment for a zero text offset. On Fedora
> 38/39 distros, the instruction trace shows unconditional branch
> instructions which do not branch to the target address, the clearest
> indication of trouble.

Ok, thanks for sharing this.  I'm ok with exposing pgoff to the python
script itself.  But I'd like to make sure if it works correctly with
PIEs that have non-zero page offsets in other places (probably ok).

Thanks,
Namhyung


> -----------------------------------------------------------------
> 
> On 10/7/2024 10:51 PM, Namhyung Kim wrote:
> > Hello,
> > 
> > Sorry for the long delay.  But can you please explain your problem in
> > more detail?  Showing ELF program (or section) header would be helpful
> > as well.
> > 
> > Is the problem when the text mapping has non-zero pgoff only?  Is the
> > kernel symbols working correctly?  Or is it just the Python script
> > broken?
> > 
> > Thanks,
> > Namhyung
> > 
> > On Mon, Sep 09, 2024 at 03:30:02PM -0600, Steve Clevenger wrote:
> >> Changes in V8:
> >>   - in arm-cs-trace-disasm.py, ensure map_pgoff is not converted to
> >>     string.
> >>   - Remove map_pgoff integer conversion in dso not found print
> >>     message.
> >>
> >> Changes in V7:
> >>   - In arm-cs-trace-disasm.py, fix print message core dump resulting
> >>     from mixed type arithmetic.
> >>   - Modify CS_ETM_TRACE_ON filter to filter zero start_addr. The
> >>     CS_ETM_TRACE_ON message is changed to print only in verbose mode.
> >>   - Removed verbose mode only notification for start_addr/stop_addr
> >>     outside of dso address range.
> >>
> >> Changes in V6:
> >>   - In arm-cs-trace-disasm.py, zero map_pgoff for kernel files. Add
> >>     map_pgoff to start/end address for dso not found message.
> >>   - Added "Reviewed-by" trailer for patches 1-3 previously reviewed
> >>     by Leo Yan in V4 and V5.
> >>
> >> Changes in V5:
> >>   - In symbol-elf.c, branch to exit_close label if open file.
> >>   - In trace_event_python.c, correct indentation. set_sym_in_dict
> >>     call parameter "map_pgoff" renamed as "addr_map_pgoff" to
> >>     match local naming.
> >>
> >> Changes in V4:
> >>   - In trace-event-python.c, fixed perf-tools-next merge problem.
> >>
> >> Changes in V3:
> >>   - Rebased to linux-perf-tools branch.
> >>   - Squash symbol-elf.c and symbol.h into same commit.
> >>   - In map.c, merge dso__is_pie() call into existing if statement.
> >>   - In arm-cs-trace-disasm.py, remove debug artifacts.
> >>
> >> Changes in V2:
> >>   - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
> >>     checks per Leo Yan review.
> >>   - Updated mailing list distribution.
> >>
> >> Steve Clevenger (4):
> >>   Add dso__is_pie call to identify ELF PIE
> >>   Force MAPPING_TYPE__IDENTIY for PIE
> >>   Add map pgoff to python dictionary based on MAPPING_TYPE
> >>   Adjust objdump start/end range per map pgoff parameter
> >>
> >>  .../scripts/python/arm-cs-trace-disasm.py     | 17 ++++--
> >>  tools/perf/util/map.c                         |  4 +-
> >>  .../scripting-engines/trace-event-python.c    | 13 +++-
> >>  tools/perf/util/symbol-elf.c                  | 61 +++++++++++++++++++
> >>  tools/perf/util/symbol.h                      |  1 +
> >>  5 files changed, 86 insertions(+), 10 deletions(-)
> >>
> >> -- 
> >> 2.44.0
> >>
> 
