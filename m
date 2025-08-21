Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6513A265
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774077; cv=none; b=oR/8kF5hMx8jJd4kxr/tayV1F2snySeYJNc8eCKVMGdMDWSD7Ue6PRjUbK6cKeWJb7YpIo6Ixw92MujiPskZBCzcVDhkQWubu5md0tSw6pO5AbqXDxJnJ+2rveKHzj+7RHOVtXkReOYL49ME8zuzQXX6LwDkXCR0EOn8izWr0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774077; c=relaxed/simple;
	bh=7nLm2KYVimt3NMawiCi/8Za5ikp2wGSO/MIyKRcI7eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN/KJ3Xl5XTM4ZkGf4RpBj1eNNinrGa2V6gUbKhHUM/pZbfJ885ZGpaqhs5npMRCcH9J7uCaV3IOpula7OucCZDE3Wi+jatIuFmzyEPD7P/SfVafzf9x1mnkzUbeXeBHQkPnBfD2PdgO2EsozNxXfJWtdVhH9s1qCMBCNXBBH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2xC93KM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2xC93KM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755774072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvNRDhpyGDgQfoFq8Zp9iAz+FTWSaNuEoQ+ZGrcAmHk=;
	b=c2xC93KMUVUR+HbtMkLVvJHHf5Gk1WWwviQnp9xyW2XdaBX/5O3d82Sap9afaAED1TF2Nl
	S+jLdUngXIKEEFIQaBuIRimrM/G8iGl9C3xDYtrsMmEORadtgYegvm73jN9bkS8xGOYSeB
	OsY9TB/SUu9jxaD28+eyy4+Lg4NsNyU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-leMb4wqOOIe7Tt6kHtcNCQ-1; Thu,
 21 Aug 2025 07:01:09 -0400
X-MC-Unique: leMb4wqOOIe7Tt6kHtcNCQ-1
X-Mimecast-MFC-AGG-ID: leMb4wqOOIe7Tt6kHtcNCQ_1755774068
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56D1C1800295;
	Thu, 21 Aug 2025 11:01:08 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.csb (unknown [10.40.3.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42252180047F;
	Thu, 21 Aug 2025 11:01:05 +0000 (UTC)
Date: Thu, 21 Aug 2025 13:01:02 +0200
From: Jakub Brnak <jbrnak@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: vmolnaro@redhat.com, acme@kernel.org, acme@redhat.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com
Subject: Re: [PATCH v3 1/7] perf test perftool_testsuite: Use absolute paths
Message-ID: <aKb8bvPkHsjxFIc5@jbrnak-thinkpadx1carbongen9.tpbc.csb>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
 <20250721132642.40906-2-jbrnak@redhat.com>
 <aIRu9IIos3_9-343@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIRu9IIos3_9-343@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jul 25, 2025 at 11:00:20PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Jul 21, 2025 at 03:26:36PM +0200, Jakub Brnak wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Test cases from perftool_testsuite are affected by the current
> > directory where the test are run. For this reason, the test
> > driver has to change the directory to the base_dir for references to
> > work correctly.
> > 
> > Utilize absolute paths when sourcing and referencing other scripts so
> > that the current working directory doesn't impact the test cases.
> > 
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> 
> I'm ok with this change but can you please remove long lines?  I'm not
> sure if we should follow the same coding style in shell scripts but long
> lines would harm readability IMHO.
> 
> Of course it can be on top of this series.
> 
> Thanks,
> Namhyung

Hi Namhyung, 
we definitley can remove long lines but we would prefer to do it as separate patch after this one if possible. Of course when continuing with upstreaming effort
of perftool-testsuite, we will avoid introducing new long lines in all new testcases.

Thanks, 
Jakub
> 
> > ---
> >  .../base_probe/test_adding_blacklisted.sh     | 13 ++---
> >  .../shell/base_probe/test_adding_kernel.sh    | 53 ++++++++++---------
> >  .../perf/tests/shell/base_probe/test_basic.sh | 19 +++----
> >  .../shell/base_probe/test_invalid_options.sh  | 11 ++--
> >  .../shell/base_probe/test_line_semantics.sh   |  7 +--
> >  tools/perf/tests/shell/base_report/setup.sh   |  6 ++-
> >  .../tests/shell/base_report/test_basic.sh     | 47 ++++++++--------
> >  tools/perf/tests/shell/common/init.sh         |  4 +-
> >  8 files changed, 84 insertions(+), 76 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> > index 8226449ac5c3..c409ca8520f8 100755
> > --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> > +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> > @@ -13,11 +13,12 @@
> >  #	they must be skipped.
> >  #
> >  
> > -# include working environment
> > -. ../common/init.sh
> > -
> > +DIR_PATH="$(dirname $0)"
> >  TEST_RESULT=0
> >  
> > +# include working environment
> > +. "$DIR_PATH/../common/init.sh"
> > +
> >  # skip if not supported
> >  BLACKFUNC_LIST=`head -n 5 /sys/kernel/debug/kprobes/blacklist 2> /dev/null | cut -f2`
> >  if [ -z "$BLACKFUNC_LIST" ]; then
> > @@ -53,7 +54,7 @@ for BLACKFUNC in $BLACKFUNC_LIST; do
> >  	PERF_EXIT_CODE=$?
> >  
> >  	# check for bad DWARF polluting the result
> > -	../common/check_all_patterns_found.pl "$REGEX_MISSING_DECL_LINE" >/dev/null < $LOGS_DIR/adding_blacklisted.err
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "$REGEX_MISSING_DECL_LINE" >/dev/null < $LOGS_DIR/adding_blacklisted.err
> >  
> >  	if [ $? -eq 0 ]; then
> >  		SKIP_DWARF=1
> > @@ -73,7 +74,7 @@ for BLACKFUNC in $BLACKFUNC_LIST; do
> >  			fi
> >  		fi
> >  	else
> > -		../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
> > +		"$DIR_PATH/../common/check_all_lines_matched.pl" "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
> >  		CHECK_EXIT_CODE=$?
> >  
> >  		SKIP_DWARF=0
> > @@ -94,7 +95,7 @@ fi
> >  $CMD_PERF list probe:\* > $LOGS_DIR/adding_blacklisted_list.log
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" < $LOGS_DIR/adding_blacklisted_list.log
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" < $LOGS_DIR/adding_blacklisted_list.log
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing blacklisted probe (should NOT be listed)"
> > diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> > index df288cf90cd6..3548faf60c8e 100755
> > --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> > +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> > @@ -13,13 +13,14 @@
> >  #		and removing.
> >  #
> >  
> > -# include working environment
> > -. ../common/init.sh
> > -
> > +DIR_PATH="$(dirname $0)"
> >  TEST_RESULT=0
> >  
> > +# include working environment
> > +. "$DIR_PATH/../common/init.sh"
> > +
> >  # shellcheck source=lib/probe_vfs_getname.sh
> > -. "$(dirname "$0")/../lib/probe_vfs_getname.sh"
> > +. "$DIR_PATH/../lib/probe_vfs_getname.sh"
> >  
> >  TEST_PROBE=${TEST_PROBE:-"inode_permission"}
> >  
> > @@ -44,7 +45,7 @@ for opt in "" "-a" "--add"; do
> >  	$CMD_PERF probe $opt $TEST_PROBE 2> $LOGS_DIR/adding_kernel_add$opt.err
> >  	PERF_EXIT_CODE=$?
> >  
> > -	../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_add$opt.err
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_add$opt.err
> >  	CHECK_EXIT_CODE=$?
> >  
> >  	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding probe $TEST_PROBE :: $opt"
> > @@ -58,7 +59,7 @@ done
> >  $CMD_PERF list probe:\* > $LOGS_DIR/adding_kernel_list.log
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defined events" "probe:${TEST_PROBE}(?:_\d+)?\s+\[Tracepoint event\]" "Metric Groups:" < $LOGS_DIR/adding_kernel_list.log
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "$RE_LINE_EMPTY" "List of pre-defined events" "probe:${TEST_PROBE}(?:_\d+)?\s+\[Tracepoint event\]" "Metric Groups:" < $LOGS_DIR/adding_kernel_list.log
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: perf list"
> > @@ -71,7 +72,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: perf list
> >  $CMD_PERF probe -l > $LOGS_DIR/adding_kernel_list-l.log
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_patterns_found.pl "\s*probe:${TEST_PROBE}(?:_\d+)?\s+\(on ${TEST_PROBE}(?:[:\+]$RE_NUMBER_HEX)?@.+\)" < $LOGS_DIR/adding_kernel_list-l.log
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "\s*probe:${TEST_PROBE}(?:_\d+)?\s+\(on ${TEST_PROBE}(?:[:\+]$RE_NUMBER_HEX)?@.+\)" < $LOGS_DIR/adding_kernel_list-l.log
> >  CHECK_EXIT_CODE=$?
> >  
> >  if [ $NO_DEBUGINFO ] ; then
> > @@ -93,9 +94,9 @@ REGEX_STAT_VALUES="\s*\d+\s+probe:$TEST_PROBE"
> >  # the value should be greater than 1
> >  REGEX_STAT_VALUE_NONZERO="\s*[1-9][0-9]*\s+probe:$TEST_PROBE"
> >  REGEX_STAT_TIME="\s*$RE_NUMBER\s+seconds (?:time elapsed|user|sys)"
> > -../common/check_all_lines_matched.pl "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUES" "$REGEX_STAT_TIME" "$RE_LINE_COMMENT" "$RE_LINE_EMPTY" < $LOGS_DIR/adding_kernel_using_probe.log
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUES" "$REGEX_STAT_TIME" "$RE_LINE_COMMENT" "$RE_LINE_EMPTY" < $LOGS_DIR/adding_kernel_using_probe.log
> >  CHECK_EXIT_CODE=$?
> > -../common/check_all_patterns_found.pl "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUE_NONZERO" "$REGEX_STAT_TIME" < $LOGS_DIR/adding_kernel_using_probe.log
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUE_NONZERO" "$REGEX_STAT_TIME" < $LOGS_DIR/adding_kernel_using_probe.log
> >  (( CHECK_EXIT_CODE += $? ))
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using added probe"
> > @@ -108,7 +109,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using added probe"
> >  $CMD_PERF probe -d $TEST_PROBE\* 2> $LOGS_DIR/adding_kernel_removing.err
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE" < $LOGS_DIR/adding_kernel_removing.err
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "Removed event: probe:$TEST_PROBE" < $LOGS_DIR/adding_kernel_removing.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "deleting added probe"
> > @@ -121,7 +122,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "deleting added probe"
> >  $CMD_PERF list probe:\* > $LOGS_DIR/adding_kernel_list_removed.log
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" < $LOGS_DIR/adding_kernel_list_removed.log
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" < $LOGS_DIR/adding_kernel_list_removed.log
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing removed probe (should NOT be listed)"
> > @@ -135,7 +136,7 @@ $CMD_PERF probe -n --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_dryrun.err
> >  PERF_EXIT_CODE=$?
> >  
> >  # check for the output (should be the same as usual)
> > -../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_dryrun.err
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_dryrun.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  # check that no probe was added in real
> > @@ -152,7 +153,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "dry run :: adding probe"
> >  $CMD_PERF probe --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_01.err
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forceadd_01.err
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forceadd_01.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: first probe adding"
> > @@ -162,7 +163,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: first pro
> >  ! $CMD_PERF probe --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_02.err
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_patterns_found.pl "Error: event \"$TEST_PROBE\" already exists." "Error: Failed to add events." < $LOGS_DIR/adding_kernel_forceadd_02.err
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "Error: event \"$TEST_PROBE\" already exists." "Error: Failed to add events." < $LOGS_DIR/adding_kernel_forceadd_02.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: second probe adding (without force)"
> > @@ -173,7 +174,7 @@ NO_OF_PROBES=`$CMD_PERF probe -l $TEST_PROBE| wc -l`
> >  $CMD_PERF probe --force --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_03.err
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_patterns_found.pl "Added new events?:" "probe:${TEST_PROBE}_${NO_OF_PROBES}" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forceadd_03.err
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "Added new events?:" "probe:${TEST_PROBE}_${NO_OF_PROBES}" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forceadd_03.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: second probe adding (with force)"
> > @@ -187,7 +188,7 @@ $CMD_PERF stat -e probe:$TEST_PROBE -e probe:${TEST_PROBE}_${NO_OF_PROBES} -x';'
> >  PERF_EXIT_CODE=$?
> >  
> >  REGEX_LINE="$RE_NUMBER;+probe:${TEST_PROBE}_?(?:$NO_OF_PROBES)?;$RE_NUMBER;$RE_NUMBER"
> > -../common/check_all_lines_matched.pl "$REGEX_LINE" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < $LOGS_DIR/adding_kernel_using_two.log
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "$REGEX_LINE" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < $LOGS_DIR/adding_kernel_using_two.log
> >  CHECK_EXIT_CODE=$?
> >  
> >  VALUE_1=`grep "$TEST_PROBE;" $LOGS_DIR/adding_kernel_using_two.log | awk -F';' '{print $1}'`
> > @@ -205,7 +206,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using doubled probe"
> >  $CMD_PERF probe --del \* 2> $LOGS_DIR/adding_kernel_removing_wildcard.err
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_patterns_found.pl "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple probes"
> > @@ -217,7 +218,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple probes"
> >  $CMD_PERF probe -nf --max-probes=512 -a 'vfs_* $params' 2> $LOGS_DIR/adding_kernel_adding_wildcard.err
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_patterns_found.pl "probe:vfs_mknod" "probe:vfs_create" "probe:vfs_rmdir" "probe:vfs_link" "probe:vfs_write" < $LOGS_DIR/adding_kernel_adding_wildcard.err
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "probe:vfs_mknod" "probe:vfs_create" "probe:vfs_rmdir" "probe:vfs_link" "probe:vfs_write" < $LOGS_DIR/adding_kernel_adding_wildcard.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  if [ $NO_DEBUGINFO ] ; then
> > @@ -240,13 +241,13 @@ test $PERF_EXIT_CODE -ne 139 -a $PERF_EXIT_CODE -ne 0
> >  PERF_EXIT_CODE=$?
> >  
> >  # check that the error message is reasonable
> > -../common/check_all_patterns_found.pl "Failed to find" "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64" < $LOGS_DIR/adding_kernel_nonexisting.err
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "Failed to find" "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64" < $LOGS_DIR/adding_kernel_nonexisting.err
> >  CHECK_EXIT_CODE=$?
> > -../common/check_all_patterns_found.pl "in this function|at this address" "Error" "Failed to add events" < $LOGS_DIR/adding_kernel_nonexisting.err
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "in this function|at this address" "Error" "Failed to add events" < $LOGS_DIR/adding_kernel_nonexisting.err
> >  (( CHECK_EXIT_CODE += $? ))
> > -../common/check_all_lines_matched.pl "Failed to find" "Error" "Probe point .+ not found" "optimized out" "Use.+\-\-range option to show.+location range" < $LOGS_DIR/adding_kernel_nonexisting.err
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "Failed to find" "Error" "Probe point .+ not found" "optimized out" "Use.+\-\-range option to show.+location range" < $LOGS_DIR/adding_kernel_nonexisting.err
> >  (( CHECK_EXIT_CODE += $? ))
> > -../common/check_no_patterns_found.pl "$RE_SEGFAULT" < $LOGS_DIR/adding_kernel_nonexisting.err
> > +"$DIR_PATH/../common/check_no_patterns_found.pl" "$RE_SEGFAULT" < $LOGS_DIR/adding_kernel_nonexisting.err
> >  (( CHECK_EXIT_CODE += $? ))
> >  
> >  if [ $NO_DEBUGINFO ]; then
> > @@ -264,7 +265,7 @@ fi
> >  $CMD_PERF probe --add "$TEST_PROBE%return \$retval" 2> $LOGS_DIR/adding_kernel_func_retval_add.err
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE%return with \\\$retval" < $LOGS_DIR/adding_kernel_func_retval_add.err
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE%return with \\\$retval" < $LOGS_DIR/adding_kernel_func_retval_add.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function with retval :: add"
> > @@ -274,7 +275,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function with retval :: add"
> >  $CMD_PERF record -e probe:$TEST_PROBE\* -o $CURRENT_TEST_DIR/perf.data -- cat /proc/cpuinfo > /dev/null 2> $LOGS_DIR/adding_kernel_func_retval_record.err
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/adding_kernel_func_retval_record.err
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/adding_kernel_func_retval_record.err
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function with retval :: record"
> > @@ -285,9 +286,9 @@ $CMD_PERF script -i $CURRENT_TEST_DIR/perf.data > $LOGS_DIR/adding_kernel_func_r
> >  PERF_EXIT_CODE=$?
> >  
> >  REGEX_SCRIPT_LINE="\s*cat\s+$RE_NUMBER\s+\[$RE_NUMBER\]\s+$RE_NUMBER:\s+probe:$TEST_PROBE\w*:\s+\($RE_NUMBER_HEX\s+<\-\s+$RE_NUMBER_HEX\)\s+arg1=$RE_NUMBER_HEX"
> > -../common/check_all_lines_matched.pl "$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script.log
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script.log
> >  CHECK_EXIT_CODE=$?
> > -../common/check_all_patterns_found.pl "$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script.log
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script.log
> >  (( CHECK_EXIT_CODE += $? ))
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function argument probing :: script"
> > diff --git a/tools/perf/tests/shell/base_probe/test_basic.sh b/tools/perf/tests/shell/base_probe/test_basic.sh
> > index 9d8b5afbeddd..e8fed67be9c1 100755
> > --- a/tools/perf/tests/shell/base_probe/test_basic.sh
> > +++ b/tools/perf/tests/shell/base_probe/test_basic.sh
> > @@ -12,11 +12,12 @@
> >  #		This test tests basic functionality of perf probe command.
> >  #
> >  
> > -# include working environment
> > -. ../common/init.sh
> > -
> > +DIR_PATH="$(dirname $0)"
> >  TEST_RESULT=0
> >  
> > +# include working environment
> > +. "$DIR_PATH/../common/init.sh"
> > +
> >  if ! check_kprobes_available; then
> >  	print_overall_skipped
> >  	exit 2
> > @@ -30,15 +31,15 @@ if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
> >  	$CMD_PERF probe --help > $LOGS_DIR/basic_helpmsg.log 2> $LOGS_DIR/basic_helpmsg.err
> >  	PERF_EXIT_CODE=$?
> >  
> > -	../common/check_all_patterns_found.pl "PERF-PROBE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "PROBE\s+SYNTAX" "PROBE\s+ARGUMENT" "LINE\s+SYNTAX" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "PERF-PROBE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "PROBE\s+SYNTAX" "PROBE\s+ARGUMENT" "LINE\s+SYNTAX" < $LOGS_DIR/basic_helpmsg.log
> >  	CHECK_EXIT_CODE=$?
> > -	../common/check_all_patterns_found.pl "LAZY\s+MATCHING" "FILTER\s+PATTERN" "EXAMPLES" "SEE\s+ALSO" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "LAZY\s+MATCHING" "FILTER\s+PATTERN" "EXAMPLES" "SEE\s+ALSO" < $LOGS_DIR/basic_helpmsg.log
> >  	(( CHECK_EXIT_CODE += $? ))
> > -	../common/check_all_patterns_found.pl "vmlinux" "module=" "source=" "verbose" "quiet" "add=" "del=" "list.*EVENT" "line=" "vars=" "externs" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "vmlinux" "module=" "source=" "verbose" "quiet" "add=" "del=" "list.*EVENT" "line=" "vars=" "externs" < $LOGS_DIR/basic_helpmsg.log
> >  	(( CHECK_EXIT_CODE += $? ))
> > -	../common/check_all_patterns_found.pl "no-inlines" "funcs.*FILTER" "filter=FILTER" "force" "dry-run" "max-probes" "exec=" "demangle-kernel" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "no-inlines" "funcs.*FILTER" "filter=FILTER" "force" "dry-run" "max-probes" "exec=" "demangle-kernel" < $LOGS_DIR/basic_helpmsg.log
> >  	(( CHECK_EXIT_CODE += $? ))
> > -	../common/check_no_patterns_found.pl "No manual entry for" < $LOGS_DIR/basic_helpmsg.err
> > +	"$DIR_PATH/../common/check_no_patterns_found.pl" "No manual entry for" < $LOGS_DIR/basic_helpmsg.err
> >  	(( CHECK_EXIT_CODE += $? ))
> >  
> >  	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
> > @@ -53,7 +54,7 @@ fi
> >  # without any args perf-probe should print usage
> >  $CMD_PERF probe 2> $LOGS_DIR/basic_usage.log > /dev/null
> >  
> > -../common/check_all_patterns_found.pl "[Uu]sage" "perf probe" "verbose" "quiet" "add" "del" "force" "line" "vars" "externs" "range" < $LOGS_DIR/basic_usage.log
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "[Uu]sage" "perf probe" "verbose" "quiet" "add" "del" "force" "line" "vars" "externs" "range" < $LOGS_DIR/basic_usage.log
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results 0 $CHECK_EXIT_CODE "usage message"
> > diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> > index 92f7254eb32a..9caeab2fe77c 100755
> > --- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> > +++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> > @@ -12,11 +12,12 @@
> >  #		This test checks whether the invalid and incompatible options are reported
> >  #
> >  
> > -# include working environment
> > -. ../common/init.sh
> > -
> > +DIR_PATH="$(dirname $0)"
> >  TEST_RESULT=0
> >  
> > +# include working environment
> > +. "$DIR_PATH/../common/init.sh"
> > +
> >  if ! check_kprobes_available; then
> >  	print_overall_skipped
> >  	exit 2
> > @@ -33,7 +34,7 @@ for opt in '-a' '-d' '-L' '-V'; do
> >  	! $CMD_PERF probe $opt 2> $LOGS_DIR/invalid_options_missing_argument$opt.err
> >  	PERF_EXIT_CODE=$?
> >  
> > -	../common/check_all_patterns_found.pl "Error: switch .* requires a value" < $LOGS_DIR/invalid_options_missing_argument$opt.err
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "Error: switch .* requires a value" < $LOGS_DIR/invalid_options_missing_argument$opt.err
> >  	CHECK_EXIT_CODE=$?
> >  
> >  	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "missing argument for $opt"
> > @@ -66,7 +67,7 @@ for opt in '-a xxx -d xxx' '-a xxx -L foo' '-a xxx -V foo' '-a xxx -l' '-a xxx -
> >  	! $CMD_PERF probe $opt > /dev/null 2> $LOGS_DIR/aux.log
> >  	PERF_EXIT_CODE=$?
> >  
> > -	../common/check_all_patterns_found.pl "Error: switch .+ cannot be used with switch .+" < $LOGS_DIR/aux.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "Error: switch .+ cannot be used with switch .+" < $LOGS_DIR/aux.log
> >  	CHECK_EXIT_CODE=$?
> >  
> >  	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "mutually exclusive options :: $opt"
> > diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> > index 20435b6bf6bc..576442d87a44 100755
> > --- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> > +++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> > @@ -13,11 +13,12 @@
> >  #		arguments are properly reported.
> >  #
> >  
> > -# include working environment
> > -. ../common/init.sh
> > -
> > +DIR_PATH="$(dirname $0)"
> >  TEST_RESULT=0
> >  
> > +# include working environment
> > +. "$DIR_PATH/../common/init.sh"
> > +
> >  if ! check_kprobes_available; then
> >  	print_overall_skipped
> >  	exit 2
> > diff --git a/tools/perf/tests/shell/base_report/setup.sh b/tools/perf/tests/shell/base_report/setup.sh
> > index 8634e7e0dda6..2fd5c97f9822 100755
> > --- a/tools/perf/tests/shell/base_report/setup.sh
> > +++ b/tools/perf/tests/shell/base_report/setup.sh
> > @@ -12,8 +12,10 @@
> >  #
> >  #
> >  
> > +DIR_PATH="$(dirname $0)"
> > +
> >  # include working environment
> > -. ../common/init.sh
> > +. "$DIR_PATH/../common/init.sh"
> >  
> >  TEST_RESULT=0
> >  
> > @@ -24,7 +26,7 @@ SW_EVENT="cpu-clock"
> >  $CMD_PERF record -asdg -e $SW_EVENT -o $CURRENT_TEST_DIR/perf.data -- $CMD_LONGER_SLEEP 2> $LOGS_DIR/setup.log
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup.log
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup.log
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "prepare the perf.data file"
> > diff --git a/tools/perf/tests/shell/base_report/test_basic.sh b/tools/perf/tests/shell/base_report/test_basic.sh
> > index adfd8713b8f8..a15d3007f449 100755
> > --- a/tools/perf/tests/shell/base_report/test_basic.sh
> > +++ b/tools/perf/tests/shell/base_report/test_basic.sh
> > @@ -12,11 +12,12 @@
> >  #
> >  #
> >  
> > -# include working environment
> > -. ../common/init.sh
> > -
> > +DIR_PATH="$(dirname $0)"
> >  TEST_RESULT=0
> >  
> > +# include working environment
> > +. "$DIR_PATH/../common/init.sh"
> > +
> >  
> >  ### help message
> >  
> > @@ -25,19 +26,19 @@ if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
> >  	$CMD_PERF report --help > $LOGS_DIR/basic_helpmsg.log 2> $LOGS_DIR/basic_helpmsg.err
> >  	PERF_EXIT_CODE=$?
> >  
> > -	../common/check_all_patterns_found.pl "PERF-REPORT" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "OVERHEAD\s+CALCULATION" "SEE ALSO" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "PERF-REPORT" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "OVERHEAD\s+CALCULATION" "SEE ALSO" < $LOGS_DIR/basic_helpmsg.log
> >  	CHECK_EXIT_CODE=$?
> > -	../common/check_all_patterns_found.pl "input" "verbose" "show-nr-samples" "show-cpu-utilization" "threads" "comms" "pid" "tid" "dsos" "symbols" "symbol-filter" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "input" "verbose" "show-nr-samples" "show-cpu-utilization" "threads" "comms" "pid" "tid" "dsos" "symbols" "symbol-filter" < $LOGS_DIR/basic_helpmsg.log
> >  	(( CHECK_EXIT_CODE += $? ))
> > -	../common/check_all_patterns_found.pl "hide-unresolved" "sort" "fields" "parent" "exclude-other" "column-widths" "field-separator" "dump-raw-trace" "children" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "hide-unresolved" "sort" "fields" "parent" "exclude-other" "column-widths" "field-separator" "dump-raw-trace" "children" < $LOGS_DIR/basic_helpmsg.log
> >  	(( CHECK_EXIT_CODE += $? ))
> > -	../common/check_all_patterns_found.pl "call-graph" "max-stack" "inverted" "ignore-callees" "pretty" "stdio" "tui" "gtk" "vmlinux" "kallsyms" "modules" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "call-graph" "max-stack" "inverted" "ignore-callees" "pretty" "stdio" "tui" "gtk" "vmlinux" "kallsyms" "modules" < $LOGS_DIR/basic_helpmsg.log
> >  	(( CHECK_EXIT_CODE += $? ))
> > -	../common/check_all_patterns_found.pl "force" "symfs" "cpu" "disassembler-style" "source" "asm-raw" "show-total-period" "show-info" "branch-stack" "group" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "force" "symfs" "cpu" "disassembler-style" "source" "asm-raw" "show-total-period" "show-info" "branch-stack" "group" < $LOGS_DIR/basic_helpmsg.log
> >  	(( CHECK_EXIT_CODE += $? ))
> > -	../common/check_all_patterns_found.pl "branch-history" "objdump" "demangle" "percent-limit" "percentage" "header" "itrace" "full-source-path" "show-ref-call-graph" < $LOGS_DIR/basic_helpmsg.log
> > +	"$DIR_PATH/../common/check_all_patterns_found.pl" "branch-history" "objdump" "demangle" "percent-limit" "percentage" "header" "itrace" "full-source-path" "show-ref-call-graph" < $LOGS_DIR/basic_helpmsg.log
> >  	(( CHECK_EXIT_CODE += $? ))
> > -	../common/check_no_patterns_found.pl "No manual entry for" < $LOGS_DIR/basic_helpmsg.err
> > +	"$DIR_PATH/../common/check_no_patterns_found.pl" "No manual entry for" < $LOGS_DIR/basic_helpmsg.err
> >  	(( CHECK_EXIT_CODE += $? ))
> >  
> >  	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
> > @@ -57,9 +58,9 @@ REGEX_LOST_SAMPLES_INFO="#\s*Total Lost Samples:\s+$RE_NUMBER"
> >  REGEX_SAMPLES_INFO="#\s*Samples:\s+(?:$RE_NUMBER)\w?\s+of\s+event\s+'$RE_EVENT_ANY'"
> >  REGEX_LINES_HEADER="#\s*Children\s+Self\s+Command\s+Shared Object\s+Symbol"
> >  REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
> > -../common/check_all_patterns_found.pl "$REGEX_LOST_SAMPLES_INFO" "$REGEX_SAMPLES_INFO" "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_basic.log
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "$REGEX_LOST_SAMPLES_INFO" "$REGEX_SAMPLES_INFO" "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_basic.log
> >  CHECK_EXIT_CODE=$?
> > -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_basic.err
> > +"$DIR_PATH/../common/check_errors_whitelisted.pl" "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_basic.err
> >  (( CHECK_EXIT_CODE += $? ))
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution"
> > @@ -74,9 +75,9 @@ PERF_EXIT_CODE=$?
> >  
> >  REGEX_LINES_HEADER="#\s*Children\s+Self\s+Samples\s+Command\s+Shared Object\s+Symbol"
> >  REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER\s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
> > -../common/check_all_patterns_found.pl "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_nrsamples.log
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_nrsamples.log
> >  CHECK_EXIT_CODE=$?
> > -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_nrsamples.err
> > +"$DIR_PATH/../common/check_errors_whitelisted.pl" "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_nrsamples.err
> >  (( CHECK_EXIT_CODE += $? ))
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "number of samples"
> > @@ -98,7 +99,7 @@ REGEX_LINE_CPUS_ONLINE="#\s+nrcpus online\s*:\s*$MY_CPUS_ONLINE"
> >  REGEX_LINE_CPUS_AVAIL="#\s+nrcpus avail\s*:\s*$MY_CPUS_AVAILABLE"
> >  # disable precise check for "nrcpus avail" in BASIC runmode
> >  test $PERFTOOL_TESTSUITE_RUNMODE -lt $RUNMODE_STANDARD && REGEX_LINE_CPUS_AVAIL="#\s+nrcpus avail\s*:\s*$RE_NUMBER"
> > -../common/check_all_patterns_found.pl "$REGEX_LINE_TIMESTAMP" "$REGEX_LINE_HOSTNAME" "$REGEX_LINE_KERNEL" "$REGEX_LINE_PERF" "$REGEX_LINE_ARCH" "$REGEX_LINE_CPUS_ONLINE" "$REGEX_LINE_CPUS_AVAIL" < $LOGS_DIR/basic_header.log
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "$REGEX_LINE_TIMESTAMP" "$REGEX_LINE_HOSTNAME" "$REGEX_LINE_KERNEL" "$REGEX_LINE_PERF" "$REGEX_LINE_ARCH" "$REGEX_LINE_CPUS_ONLINE" "$REGEX_LINE_CPUS_AVAIL" < $LOGS_DIR/basic_header.log
> >  CHECK_EXIT_CODE=$?
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "header"
> > @@ -129,9 +130,9 @@ PERF_EXIT_CODE=$?
> >  
> >  REGEX_LINES_HEADER="#\s*Children\s+Self\s+sys\s+usr\s+Command\s+Shared Object\s+Symbol"
> >  REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
> > -../common/check_all_patterns_found.pl "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_cpuut.log
> > +"$DIR_PATH/../common/check_all_patterns_found.pl" "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_cpuut.log
> >  CHECK_EXIT_CODE=$?
> > -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_cpuut.err
> > +"$DIR_PATH/../common/check_errors_whitelisted.pl" "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_cpuut.err
> >  (( CHECK_EXIT_CODE += $? ))
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "show CPU utilization"
> > @@ -144,9 +145,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "show CPU utilization"
> >  $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --pid=1 > $LOGS_DIR/basic_pid.log 2> $LOGS_DIR/basic_pid.err
> >  PERF_EXIT_CODE=$?
> >  
> > -grep -P -v '^#' $LOGS_DIR/basic_pid.log | grep -P '\s+[\d\.]+%' | ../common/check_all_lines_matched.pl "systemd|init"
> > +grep -P -v '^#' $LOGS_DIR/basic_pid.log | grep -P '\s+[\d\.]+%' | "$DIR_PATH/../common/check_all_lines_matched.pl" "systemd|init"
> >  CHECK_EXIT_CODE=$?
> > -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_pid.err
> > +"$DIR_PATH/../common/check_errors_whitelisted.pl" "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_pid.err
> >  (( CHECK_EXIT_CODE += $? ))
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "pid"
> > @@ -159,9 +160,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "pid"
> >  $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --symbols=dummynonexistingsymbol > $LOGS_DIR/basic_symbols.log 2> $LOGS_DIR/basic_symbols.err
> >  PERF_EXIT_CODE=$?
> >  
> > -../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < $LOGS_DIR/basic_symbols.log
> > +"$DIR_PATH/../common/check_all_lines_matched.pl" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < $LOGS_DIR/basic_symbols.log
> >  CHECK_EXIT_CODE=$?
> > -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_symbols.err
> > +"$DIR_PATH/../common/check_errors_whitelisted.pl" "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_symbols.err
> >  (( CHECK_EXIT_CODE += $? ))
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-existing symbol"
> > @@ -174,9 +175,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-existing symbol"
> >  $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --symbol-filter=map > $LOGS_DIR/basic_symbolfilter.log 2> $LOGS_DIR/basic_symbolfilter.err
> >  PERF_EXIT_CODE=$?
> >  
> > -grep -P -v '^#' $LOGS_DIR/basic_symbolfilter.log | grep -P '\s+[\d\.]+%' | ../common/check_all_lines_matched.pl "\[[k\.]\]\s+.*map"
> > +grep -P -v '^#' $LOGS_DIR/basic_symbolfilter.log | grep -P '\s+[\d\.]+%' | "$DIR_PATH/../common/check_all_lines_matched.pl" "\[[k\.]\]\s+.*map"
> >  CHECK_EXIT_CODE=$?
> > -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_symbolfilter.err
> > +"$DIR_PATH/../common/check_errors_whitelisted.pl" "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_symbolfilter.err
> >  (( CHECK_EXIT_CODE += $? ))
> >  
> >  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "symbol filter"
> > diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
> > index 26c7525651e0..cbfc78bec974 100644
> > --- a/tools/perf/tests/shell/common/init.sh
> > +++ b/tools/perf/tests/shell/common/init.sh
> > @@ -11,8 +11,8 @@
> >  #
> >  
> >  
> > -. ../common/settings.sh
> > -. ../common/patterns.sh
> > +. "$(dirname $0)/../common/settings.sh"
> > +. "$(dirname $0)/../common/patterns.sh"
> >  
> >  THIS_TEST_NAME=`basename $0 .sh`
> >  
> > -- 
> > 2.50.1
> > 
> 

