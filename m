Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683BB1C4A24
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616833; cv=none; b=ua+Ayz/FcKAq5L72WNG4wCq0hXwF6ACBJUW6BKcCPbmE3L37mHssrxD3CKmL1ZzvuaW312PuUOGUOyPaOS/9oK7CT31q8d3O4QCYdtZkozdw7OaD0kmvhU4PG7ygptfnrrwBYdTXcJWeBP9F9FKwq8Qcl+u6V+7ebUHRGIfsKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616833; c=relaxed/simple;
	bh=QaHMZOneZvuEekxDd5TsDcU5RysywBnrTy6tjSM4YEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbdiLdwy41Xrf4qDr+ZqX7MJbSPJ2feVfCaW2jDH1L2qkNo9QPuq551l/4WzqGkQvOxPEmY7IrZ9y5jnAOlQEyoRx6d6sJ7K467/Q57SNOEfxKNJMCVO+SMDvSHSPovIwUkvcLtlNtr3Dg3lnseRipmrtVhPNUY/Uu5401cnRcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B78931682;
	Tue, 26 Nov 2024 02:27:40 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5973C3F5A1;
	Tue, 26 Nov 2024 02:27:10 -0800 (PST)
Date: Tue, 26 Nov 2024 10:27:05 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Guilherme Amadio <amadio@gentoo.org>, acme@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: perf test for inet_pton probe fails to match stacktrace
Message-ID: <20241126102705.GA15252@e132581.arm.com>
References: <Z0D5FDu/sErQ0V/2@gentoo.org>
 <20241124105053.GA812108@e132581.arm.com>
 <Z0R3ySrb8iZQd17O@gentoo.org>
 <Z0VXvySyHm4q4r2c@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0VXvySyHm4q4r2c@google.com>

On Mon, Nov 25, 2024 at 09:08:15PM -0800, Namhyung Kim wrote:

[...]

> > Using nm $libc in both cases, and increasing max-stack to 4 allows the test to pass:
> >
> > $ sudo ./perf test -vF pton
> > --- start ---
> > ping 1237113 [000] 18561.204983: probe_libc:inet_pton: (7f7c34d38eb7)
> > 7f7c34d38eb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> > 7f7c34d4b517 gaih_inet+0x112 (/usr/lib64/libc.so.6)
> > 7f7c34d4cb73 getaddrinfo+0x133 (/usr/lib64/libc.so.6)
> > 55680ac46518 [unknown] (/usr/bin/ping)
> > ---- end ----
> >  86: probe libc's inet_pton & backtrace it with ping                 : Ok
> 
> I think it's very fragile as it depends on specific entries in the call
> stack.  As we want to test if perf probe (for uprobes) and perf record
> working correctly, maybe it can just check the number of samples only.
> 
> Arnaldo, what do you think?

Though this question is asking Arnaldo, I have a different idea for
fixing the test ;)

The middle entries in the callchain are varied on different archs and
distro.  E.g. Guilherme reported back the '-D' option is not needed but
at my side it is required on Arm64 machine with Ubuntu distro.

However, the three entries in the callchain are existed consistently:

  ping 1237113 [000] 18561.204983: probe_libc:inet_pton: (7f7c34d38eb7)
  7f7c34d38eb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
  ...
  55680ac46518 [unknown] (/usr/bin/ping)

We can change the code to only matching these three entries.  The
change is as below.  We can consolidate the code for all archs
(I am not 100% sure for x390x so I leave it).

Please let me know if this makes sense for you?

Thanks,
Leo

---8<---

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 47a26f25db9f..6ef58aedf2d8 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -43,17 +43,8 @@ trace_libc_inet_pton_backtrace() {
 		echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlined|.*/bin/ping.*\)$" >> $expected
 		;;
-	ppc64|ppc64le)
-		eventattr='max-stack=4'
-		# Add gaih_inet to expected backtrace only if it is part of libc.
-		if nm $libc | grep -F -q gaih_inet.; then
-			echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		fi
-		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
-		;;
 	*)
-		eventattr='max-stack=3'
+		eventattr='max-stack=4'
 		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	esac
@@ -76,14 +67,23 @@ trace_libc_inet_pton_backtrace() {
 	fi
 	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
 
-	exec 3<$perf_script
 	exec 4<$expected
-	while read line <&3 && read -r pattern <&4; do
+	while read -r pattern <&4; do
+		echo "pattern: $pattern"
 		[ -z "$pattern" ] && break
-		echo $line
-		echo "$line" | grep -E -q "$pattern"
-		if [ $? -ne 0 ] ; then
-			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
+
+		exec 3<$perf_script
+		while read line <&3; do
+			[ -z "$line" ] && break
+			echo "line: $line"
+			echo "$line" | grep -E -q "$pattern"
+			found=$?
+			echo "found=$found"
+			[ $found -eq 0 ] && break
+		done
+
+		if [ $found -ne 0 ] ; then
+			printf "FAIL: unfound the expected backtrace entry \"%s\"\n" "$pattern"
 			return 1
 		fi
 	done
